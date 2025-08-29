import os, osproc, strutils

type
  SysInfo* = object
    osName*: string
    hostname*: string
    cpu*: string
    memory*: string

proc getHostname*(): string =
  ## Cross-platform hostname getter
  when defined(windows):
    result = getEnv("COMPUTERNAME")
  else:
    # On Linux/macOS, HOSTNAME is often set in env
    result = getEnv("HOSTNAME")
    if result.len == 0:
      try:
        result = execProcess("hostname").strip()
      except:
        result = "unknown-host"

proc getSysInfo*(): SysInfo =
  ## Fetches basic system information
  result.hostname = getHostname()

  when defined(windows):
    result.osName = "Windows " & getEnv("OS")
    try:
      result.cpu = execProcess("wmic cpu get name").splitLines()[1].strip()
      result.memory = execProcess("wmic computersystem get TotalPhysicalMemory").splitLines()[1].strip()
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
      result.memory = execProcess("sysctl -n hw.memsize").strip()
    except:
      result.cpu = "Unknown CPU"
      result.memory = "Unknown Memory"
