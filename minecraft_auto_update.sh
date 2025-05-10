#!/bin/bash

# KONFIGURACJA
SERVER_DIR="/home/root2/mcserver"
JAR_NAME="nukkit.jar"
VERSION_FILE="$SERVER_DIR/.nukkit_version"
DOWNLOAD_URL="https://repo.opencollab.dev/api/maven/latest/file/maven-snapshots/cn/nukkit/nukkit/1.0-SNAPSHOT?extension=jar"
TEMP_JAR="/tmp/nukkit-latest.jar"

# 1. Zatrzymaj serwis
echo "[*] Zatrzymywanie serwisu nukkit..."
sudo systemctl stop nukkit.service

# 2. Pobierz nowy JAR
echo "[*] Pobieranie najnowszej wersji Nukkit..."
curl -L -o "$TEMP_JAR" "$DOWNLOAD_URL"

# 3. Oblicz SHA256 nowej wersji
NEW_HASH=$(sha256sum "$TEMP_JAR" | awk '{print $1}')

# 4. Sprawdź poprzednią wersję
if [ -f "$VERSION_FILE" ]; then
    OLD_HASH=$(cat "$VERSION_FILE")
else
    OLD_HASH="none"
fi

echo "Aktualna suma SHA: $OLD_HASH"
echo "Nowa suma SHA:     $NEW_HASH"

# 5. Porównaj i podmień jeśli różne
if [ "$NEW_HASH" != "$OLD_HASH" ]; then
    echo "[*] Wykryto nową wersję Nukkit. Aktualizacja..."

    mv "$TEMP_JAR" "$SERVER_DIR/$JAR_NAME"
    echo "$NEW_HASH" > "$VERSION_FILE"

    echo "[+] Serwer Nukkit został zaktualizowany."
else
    echo "[=] Nukkit jest już w najnowszej wersji."
    rm "$TEMP_JAR"
fi

# 6. Uruchom serwis ponownie
echo "[*] Uruchamianie serwisu nukkit..."
sudo systemctl start nukkit.service

echo "[✔] Gotowe."