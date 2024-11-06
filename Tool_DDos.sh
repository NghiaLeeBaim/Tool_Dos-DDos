#!/bin/bash

echo "Nhap so lenh muon thuc thi (recomment: 5)"
read -r count 

echo "###################################"
# Kiem tra so nhap vao co phai la so khong
if ! [[ "$count" =~ ^[0-9]+$ ]] || [ "$count" -le 0 ]; then #kiem tra cac so co la cac so tu 0 -9(hay con goi la cac so tu nhien) hoac cac so co nho hon bang 0
    echo "so luong lenh nhap khong hop le vui long nhap lai"
    exit 1
fi

commands=()  # tao mang

#Nhap lenh theo so luong da nhap
for ((i = 1; i <= count; i++)); do
    echo "Nhập lệnh thứ $i: "
    read -r cmd
    commands+=("$cmd")  # Them lenh vao mang
done

echo "###################################"
echo -e "Các câu lệnh sẽ thực thi là: "
for cmd in "${commands[@]}"; do
    echo "- $cmd" 
done
echo "###################################"
# Dung xargs de chay song song cac cau lenh
printf "\n%s\n" "${commands[@]}" | xargs -I CMD -P $count bash -c 'CMD'

echo "Tất cả lệnh đã được thực thi."
