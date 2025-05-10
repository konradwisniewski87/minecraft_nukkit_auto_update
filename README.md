# 🛠 Nukkit Server Auto-Updater

A Bash script to automatically update your Nukkit server to the latest version available from the OpenCollab Maven snapshot repository.

---

## 🔧 Features

- Stops the running Nukkit systemd service.
- Downloads the latest snapshot JAR.
- Verifies the SHA256 hash to detect new versions.
- Replaces the current server JAR with the new version only if it's different.
- Restarts the Nukkit service after update.

---

## 📁 Installation

### 1. Save the Script

Create the file:

```bash
sudo nano /var/script/minecraft_auto_update.sh
```

Paste your script into it and save.

### 2. Make the Script Executable
```bash
sudo chmod +x /var/script/minecraft_auto_update.sh
```

---

## ⚙️ Script Configuration

### Ensure your script contains the following settings:
```bash
SERVER_DIR="/home/root2/mcserver"
JAR_NAME="nukkit.jar"
VERSION_FILE="$SERVER_DIR/.nukkit_version"
DOWNLOAD_URL="https://repo.opencollab.dev/api/maven/latest/file/maven-snapshots/cn/nukkit/nukkit/1.0-SNAPSHOT?extension=jar"
TEMP_JAR="/tmp/nukkit-latest.jar"
```

- `SERVER_DIR`: Path to your Nukkit server directory.
- `JAR_NAME`: Name for the server JAR file.
- `VERSION_FILE`: File where the script stores the SHA256 hash of the current JAR.
- `DOWNLOAD_URL`: Endpoint for the latest Nukkit snapshot.
- `TEMP_JAR`: Temporary location for the downloaded file.

---

## 🕒 Automating with Cron


### 1. Open root crontab:
```bash
sudo crontab -e
```

### 2. Add the job:
This example runs the updater daily at 5:00 AM.
```bash
0 5 * * * sudo bash /var/script/minecraft_auto_update.sh
```

---

## 🧪 Manual Run
### You can run the updater manually anytime:
```bash
sudo bash /var/script/minecraft_auto_update.sh
```
