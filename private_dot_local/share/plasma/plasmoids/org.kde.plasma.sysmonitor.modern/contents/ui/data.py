#!/usr/bin/env python3
import sys
import os
import json
import time
import subprocess

STATE_FILE = "/tmp/sysmonitor_state.json"

def read_cpu_ticks():
    try:
        with open("/proc/stat", "r") as f:
            for line in f:
                if line.startswith("cpu "):
                    parts = [float(x) for x in line.split()[1:]]
                    idle = parts[3] + parts[4]
                    total = sum(parts)
                    return total, idle
    except Exception:
        pass
    return 0.0, 0.0

def read_cpu_temp():
    try:
        for hwmon_dir in os.listdir("/sys/class/hwmon"):
            path = os.path.join("/sys/class/hwmon", hwmon_dir)
            name_file = os.path.join(path, "name")
            if os.path.exists(name_file):
                with open(name_file, "r") as f:
                    if f.read().strip() == "coretemp":
                        temp_file = os.path.join(path, "temp1_input")
                        if os.path.exists(temp_file):
                            with open(temp_file, "r") as tf:
                                return float(tf.read().strip()) / 1000.0
    except Exception:
        pass
    try:
        for hwmon_dir in os.listdir("/sys/class/hwmon"):
            path = os.path.join("/sys/class/hwmon", hwmon_dir)
            temp_file = os.path.join(path, "temp1_input")
            if os.path.exists(temp_file):
                with open(temp_file, "r") as tf:
                    return float(tf.read().strip()) / 1000.0
    except Exception:
        pass
    return 0.0

def read_ram():
    try:
        meminfo = {}
        with open("/proc/meminfo", "r") as f:
            for line in f:
                parts = line.split(":")
                if len(parts) == 2:
                    key = parts[0].strip()
                    val = parts[1].strip().split()[0]
                    meminfo[key] = float(val)
        
        total_kb = meminfo.get("MemTotal", 0.0)
        available_kb = meminfo.get("MemAvailable", 0.0)
        used_kb = total_kb - available_kb
        
        total_gb = total_kb / (1024.0 * 1024.0)
        used_gb = used_kb / (1024.0 * 1024.0)
        pct = (used_kb / total_kb * 100.0) if total_kb > 0 else 0.0
        return used_gb, total_gb, pct
    except Exception:
        pass
    return 0.0, 0.0, 0.0

def read_net_bytes():
    try:
        total_rx = 0
        total_tx = 0
        with open("/proc/net/dev", "r") as f:
            for line in f:
                if ":" in line:
                    parts = line.split(":")
                    if len(parts) == 2:
                        ifparts = parts[0].strip()
                        if ifparts == "lo":
                            continue
                        stats = parts[1].strip().split()
                        if len(stats) >= 8:
                            total_rx += int(stats[0])
                            total_tx += int(stats[8])
    except Exception:
        pass
    return total_rx, total_tx

def read_gpu():
    try:
        cmd = ["/usr/bin/nvidia-smi", "--query-gpu=utilization.gpu,temperature.gpu,memory.used,memory.total", "--format=csv,noheader,nounits"]
        res = subprocess.check_output(cmd, stderr=subprocess.DEVNULL).decode("utf-8").strip()
        parts = [x.strip() for x in res.split(",")]
        if len(parts) == 4:
            gpu_usage = float(parts[0])
            gpu_temp = float(parts[1])
            vram_used_mib = float(parts[2])
            vram_total_mib = float(parts[3])
            
            vram_used_gb = vram_used_mib / 1024.0
            vram_total_gb = vram_total_mib / 1024.0
            vram_pct = (vram_used_mib / vram_total_mib * 100.0) if vram_total_mib > 0 else 0.0
            return gpu_usage, gpu_temp, vram_used_gb, vram_total_gb, vram_pct
    except Exception:
        pass
    return 0.0, 0.0, 0.0, 0.0, 0.0

def main():
    curr_time = time.time()
    curr_cpu_total, curr_cpu_idle = read_cpu_ticks()
    curr_rx, curr_tx = read_net_bytes()
    
    prev_state = {}
    if os.path.exists(STATE_FILE):
        try:
            with open(STATE_FILE, "r") as f:
                prev_state = json.load(f)
        except Exception:
            pass
            
    state_to_save = {
        "timestamp": curr_time,
        "cpu_total": curr_cpu_total,
        "cpu_idle": curr_cpu_idle,
        "net_rx": curr_rx,
        "net_tx": curr_tx
    }
    try:
        with open(STATE_FILE, "w") as f:
            json.dump(state_to_save, f)
    except Exception:
        pass
        
    cpu_usage = 0.0
    if prev_state:
        prev_total = prev_state.get("cpu_total", 0.0)
        prev_idle = prev_state.get("cpu_idle", 0.0)
        total_diff = curr_cpu_total - prev_total
        idle_diff = curr_cpu_idle - prev_idle
        if total_diff > 0:
            cpu_usage = (1.0 - (idle_diff / total_diff)) * 100.0
            
    net_down_speed = 0.0
    net_up_speed = 0.0
    if prev_state:
        prev_time = prev_state.get("timestamp", curr_time)
        prev_rx = prev_state.get("net_rx", curr_rx)
        prev_tx = prev_state.get("net_tx", curr_tx)
        dt = curr_time - prev_time
        if dt > 0:
            net_down_speed = (curr_rx - prev_rx) / dt
            net_up_speed = (curr_tx - prev_tx) / dt
            
    cpu_temp = read_cpu_temp()
    ram_used_gb, ram_total_gb, ram_pct = read_ram()
    gpu_usage, gpu_temp, vram_used_gb, vram_total_gb, vram_pct = read_gpu()
    
    def format_speed(speed_bytes):
        if speed_bytes < 1024:
            return f"{speed_bytes:.0f} B/s"
        elif speed_bytes < 1024 * 1024:
            return f"{speed_bytes / 1024.0:.1f} KB/s"
        else:
            return f"{speed_bytes / (1024.0 * 1024.0):.1f} MB/s"
            
    result = {
        "cpu_usage": round(cpu_usage, 1),
        "cpu_temp": round(cpu_temp, 1),
        "ram_used_gb": round(ram_used_gb, 1),
        "ram_total_gb": round(ram_total_gb, 1),
        "ram_pct": round(ram_pct, 1),
        "gpu_usage": round(gpu_usage, 1),
        "gpu_temp": round(gpu_temp, 1),
        "vram_used_gb": round(vram_used_gb, 1),
        "vram_total_gb": round(vram_total_gb, 1),
        "vram_pct": round(vram_pct, 1),
        "net_down_speed": round(net_down_speed, 1),
        "net_up_speed": round(net_up_speed, 1),
        "net_down_formatted": format_speed(net_down_speed),
        "net_up_formatted": format_speed(net_up_speed)
    }
    
    print(json.dumps(result))

if __name__ == "__main__":
    main()
