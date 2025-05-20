# Artifact Sweeper

## Overview
This repository provides a modular batch script named **"ArtifactSweeper"** designed to clean artifacts created by legitimate tools frequently abused by attackers, particularly in human-operated ransomware incidents. The script is based on detailed artifact analysis from the PDF report titled "Analysis on Legit Tools Abused in Human Operated Ransomware" by Trend Micro.

- Attackers leveraging human-operated ransomware typically misuse these legitimate tools for defense evasion.
- Commercial tools have seen a significant rise in abuse due to their multifunctionality and ease of blending into typical enterprise operations.


## Commercial Tools Overview

### Commercial Remote Monitoring & Management (RMM) Tools
- Allow attackers remote control of victim PCs through relay servers similar to Remote Desktop Protocol (RDP).
- Feature-rich capabilities include script and command execution, file transfer, and task management.

### Commercial SYNC Tools
- These tools provide command-line or GUI-based synchronization of specific files or directories to cloud storage or directly to remote machines.

### Common MITRE ATT&CK Tactics

| MITRE Tactic                | Abused Tools |
|-----------------------------|--------------|
| [TA0011] Command and Control| RMM Tools    |
| [TA0010] Exfiltration       | SYNC Tools   |

### Supported Tools
- AnyDesk
- Atera
- Splashtop
- ConnectWise
- TeamViewer
- Ngrok
- Remote Utilities
- Supremo
- FileZilla
- Rclone
- TightVNC
- LogMeIn
- WinSCP
