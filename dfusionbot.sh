#!/bin/bash

curl -s https://data.zamzasalim.xyz/file/uploads/asclogo.sh | bash
sleep 5

echo "DFUSION BOT"
sleep 2
# Memilih tempat menjalankan bot
echo "Dimana Kamu menjalankan bot ini?"
echo "1. VPS"
echo "2. Termux"
read -p "Pilih kategori (1/2): " choice

# Mengecek pilihan dan menyesuaikan
if [ "$choice" -eq 1 ]; then
    echo "Anda memilih VPS. Melanjutkan dengan pengaturan VPS..."
    # Di VPS, kita pastikan git, npm, dan screen (jika perlu) sudah terinstal
    echo "Memeriksa apakah git terinstal..."
    if ! command -v git &> /dev/null
    then
        echo "Git belum terinstal. Menginstal git..."
        sudo apt update && sudo apt upgrade -y
        sudo apt install -y git
    else
        echo "Git sudah terinstal."
    fi

    echo "Memeriksa apakah npm terinstal..."
    if ! command -v npm &> /dev/null
    then
        echo "npm belum terinstal. Menginstal npm..."
        sudo apt install -y npm
    else
        echo "npm sudah terinstal."
    fi

    # Memastikan screen terinstal di VPS (opsional)
    echo "Memeriksa apakah screen terinstal..."
    if ! command -v screen &> /dev/null
    then
        echo "Screen belum terinstal. Menginstal screen..."
        sudo apt install -y screen
    else
        echo "Screen sudah terinstal."
    fi

    # Meng-clone repository
    echo "Meng-clone repository..."
    git clone https://github.com/zamzasalim/dfusionbot.git
    cd dfusionbot

    # Meminta input untuk PRIVATE_KEY
    echo "Masukkan PRIVATE_KEY Anda: "
    read PRIVATE_KEY

    # Menambahkan PRIVATE_KEY ke file .env
    echo "PRIVATE_KEY=$PRIVATE_KEY" >> .env

    # Menginstal dependensi dengan npm
    echo "Menginstal dependensi..."
    npm install

    # Menjalankan aplikasi dalam screen
    echo "Done! Bot berjalan dalam session screen. Gunakan 'screen -r dfusion' untuk melihat log."
    screen -S dfusion -d -m node single.js

elif [ "$choice" -eq 2 ]; then
    echo "Anda memilih Termux. Melanjutkan dengan pengaturan Termux..."
    # Di Termux, kita pastikan git dan npm sudah terinstal
    echo "Memeriksa apakah git terinstal..."
    if ! command -v git &> /dev/null
    then
        echo "Git belum terinstal. Menginstal git..."
        pkg update && pkg upgrade -y
        pkg install -y git
    else
        echo "Git sudah terinstal."
    fi

    echo "Memeriksa apakah npm terinstal..."
    if ! command -v npm &> /dev/null
    then
        echo "npm belum terinstal. Menginstal npm..."
        pkg install -y nodejs
    else
        echo "npm sudah terinstal."
    fi

    # Meng-clone repository
    echo "Meng-clone repository..."
    git clone https://github.com/zamzasalim/dfusionbot.git
    cd dfusionbot

    # Meminta input untuk PRIVATE_KEY
    echo "Masukkan PRIVATE_KEY Anda: "
    read PRIVATE_KEY

    # Menambahkan PRIVATE_KEY ke file .env
    echo "PRIVATE_KEY=$PRIVATE_KEY" >> .env

    # Menginstal dependensi dengan npm
    echo "Menginstal dependensi..."
    npm install

    # Menjalankan aplikasi di background
    echo "Menjalankan aplikasi di background..."
    nohup node single.js &

    echo "Done! Bot berjalan di background. Anda dapat menutup terminal."
else
    echo "Pilihan tidak valid. Mohon pilih 1 untuk VPS atau 2 untuk Termux."
fi
