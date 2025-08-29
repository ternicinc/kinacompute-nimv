import os, osproc, strutils

type
  SysInfo* = object
    osName*: string
    hostname*: string
    cpu*: string
    memory*: string
    diskRoot*: string

proc getHostname*(): string =
  ## Cross-platform hostname getter
  when defined(windows):
    result = getEnv("COMPUTERNAME")
  else:
    result = getEnv("HOSTNAME")
    if result.len == 0:
      try:
        result = execProcess("hostname").strip()
      except:
        result = "unknown-host"

proc getDiskRoot*(): string =
  ## Root filesystem total size
  when defined(windows):
    try:
      result = execProcess("wmic logicaldisk where \"DeviceID='C:'\" get Size /value")
        .splitLines()
        .filterIt(it.contains("Size"))
        .mapIt(it.split("=").last.strip())
        .join("")
      if result.len > 0:
        result = $(parseBiggestInt(result) div 1024 div 1024 div 1024) & " GB"
      else:
        result = "Unknown Disk"
    except:
      result = "Unknown Disk"
  else:
    try:
      result = execProcess("df -h --output=size / | tail -1").strip()
    except:
      result = "Unknown Disk"

proc getSysInfo*(): SysInfo =
  ## Fetches basic system information
  result.hostname = getHostname()
  result.diskRoot = getDiskRoot()
    
  when defined(windows):
    result.osName = "Windows " & getEnv("OS")
    try:
      result.cpu = execProcess("wmic cpu get name").splitLines()[1].strip()
      result.memory = execProcess("wmic computersystem get TotalPhysicalMemory").splitLines()[1].strip() & " bytes"
    except:
      result.cpu = "Unknown CPU"
      result.memory = "Unknown Memory"
  
  elif defined(linux):
    result.osName = execProcess("uname -o").strip()
    try:
      result.cpu = execProcess("lscpu | grep 'Model name:' | cut -d: -f2").strip()
      result.memory = execProcess("free -h | grep Mem | awk '{print $2}'").strip()
    except:
      result.cpu = "Unknown CPU"
      result.memory = "Unknown Memory"

  elif defined(macosx):
    result.osName = "macOS"
    try:
      result.cpu = execProcess("sysctl -n machdep.cpu.brand_string").strip()
      result.memory = execProcess("sysctl -n hw.memsize").strip() & " bytes"
    except:
      result.cpu = "Unknown CPU"
      result.memory = "Unknown Memory"
