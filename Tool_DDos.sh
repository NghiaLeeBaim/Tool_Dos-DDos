#
## Product: Marvin/Nghiale/Freden
#
# Version 1.0
#!/bin/bash

# echo "Nhap so lenh muon thuc thi (recomment: 5)"
# read -r count 

# echo "###################################"
# Kiem tra so nhap vao co phai la so khong
# if ! [[ "$count" =~ ^[0-9]+$ ]] || [ "$count" -le 0 ]; then #kiem tra cac so co la cac so tu 0 -9(hay con goi la cac so tu nhien) hoac cac so co nho hon bang 0
#     echo "so luong lenh nhap khong hop le vui long nhap lai"
#     exit 1
# fi

# commands=()  # tao mang

# #Nhap lenh theo so luong da nhap
# for ((i = 1; i <= count; i++)); do
#     echo "Nhập lệnh thứ $i: "
#     read -r cmd
#     commands+=("$cmd")  # Them lenh vao mang
# done

# echo "###################################"
# echo -e "Các câu lệnh sẽ thực thi là: "
# for cmd in "${commands[@]}"; do
#     echo "- $cmd" 
# done
# echo "###################################"
# # Dung xargs de chay song song cac cau lenh
# printf "\n%s\n" "${commands[@]}" | xargs -I CMD -P $count bash -c 'CMD'

# echo "Tất cả lệnh đã được thực thi."

# Version 2.0

# #!/bin/bash

# # gia tri default tránh bị overload CPU
# default_count=5

# echo "Nhap so luong lenh thuc thi(de xuat: $default_count):"
# read -r count

# if [[ -z "$count" ]]; then
#     count=$default_count
# fi

# echo "###################################"
# # kiem tra so hop le
# if ! [[ "$count" =~ ^[0-9]+$ ]] || [ "$count" -le 0 ]; then
#     echo "Số lượng lệnh không hợp lệ, vui lòng nhập lại"
#     exit 1
# fi

# echo "Lap lai lenh vua nhap? (y/n)"
# read -r repeat_option

# commands=()        # mang luu lenh
# repeat_counts=()   # mang luu so lan nhap lenh

# # Nhap lenh thuc thi va so lan
# for ((i = 1; i <= count; i++)); do
#     echo "Nhap lenh $i: "
#     read -r cmd

#     # Kiem tra lenh lap
#     if [[ "$repeat_option" == "y" ]]; then
#         echo "Nhap so lan thuc hien \"$cmd\": "
#         read -r repeat_count

#         if ! [[ "$repeat_count" =~ ^[0-9]+$ ]] || [ "$repeat_count" -le 0 ]; then
#             echo "So lan khong hop le (default=1)"
#             repeat_count=1
#         fi
#     else
#         repeat_count=1 
#     fi

#     commands+=("$cmd")            
#     repeat_counts+=("$repeat_count")
# done

# echo "###################################"
# echo "Cau lenh thuc thi gom:"
# for i in "${!commands[@]}"; do
#     echo "- ${commands[$i]} (Thuc hien: ${repeat_counts[$i]} )"
# done
# echo "###################################"

# # Dung xargs chay song song cac lenh
# for i in "${!commands[@]}"; do
#     cmd="${commands[$i]}"
#     repeat_count="${repeat_counts[$i]}"

#     for ((j = 1; j <= repeat_count; j++)); do
#         echo "$cmd" | xargs -I CMD -P 5 bash -c 'CMD'
#     done
# done

# echo "Done"

# Version 3.0

#!/bin/bash

# Biến toàn cục
default_count=5

# Hàm hiển thị thông báo đầu
function display_intro() {
    echo "Kết quả thực thi lệnh sẽ không được ghi vào file log."
}

# Hàm xử lý khi nhấn Ctrl+C
function handle_interrupt() {
    echo -e "\nĐã nhận tín hiệu ngắt. Thoát chương trình..."
    exit 1
}

# Gắn tín hiệu SIGINT (Ctrl+C) vào hàm handle_interrupt
trap handle_interrupt SIGINT

# Hàm kiểm tra tải hệ thống
function check_system_load() {
    local cpu_load mem_free
    cpu_load=$(awk '{print $1}' < /proc/loadavg)
    mem_free=$(awk '/MemFree/ {print $2}' < /proc/meminfo)

    if (( $(echo "$cpu_load > 1.0" | bc -l) )); then
        echo "Cảnh báo: Tải CPU cao. Hệ thống có thể bị quá tải."
    fi
    
    if (( mem_free < 102400 )); then  # Kiểm tra nếu RAM trống ít hơn 100MB
        echo "Cảnh báo: Bộ nhớ thấp. Hệ thống có thể bị quá tải."
    fi
}

# Hàm kiểm tra firewall
function check_firewall() {
    if iptables -L | grep -q "DROP"; then
        echo "Cảnh báo: Firewall đang chặn một số kết nối. Kiểm tra kỹ trước khi tiếp tục."
    fi
}

# Hàm lấy số lượng lệnh muốn thực thi
function get_command_count() {
    echo "Nhập số lượng lệnh muốn thực thi (đề xuất: $default_count):"
    read -r count
    [[ -z "$count" ]] && count=$default_count

    if ! [[ "$count" =~ ^[0-9]+$ ]] || [ "$count" -le 0 ]; then
        echo "Số lượng lệnh không hợp lệ, vui lòng nhập lại"
        exit 1
    fi
}

# Hàm lấy danh sách lệnh và số lần thực thi
function get_commands() {
    local count="$1"
    echo "Bạn có muốn lặp lại mỗi lệnh nhiều lần không? (y/n)"
    read -r repeat_option

    commands=()
    repeat_counts=()

    for ((i = 1; i <= count; i++)); do
        echo "Nhập lệnh thứ $i: "
        read -r cmd

        if [[ "$repeat_option" == "y" ]]; then
            echo "Nhập số lần thực hiện lệnh \"$cmd\": "
            read -r repeat_count

            if ! [[ "$repeat_count" =~ ^[0-9]+$ ]] || [ "$repeat_count" -le 0 ]; then
                echo "Số lần thực hiện không hợp lệ, mặc định sẽ là 1"
                repeat_count=1
            fi
        else
            repeat_count=1
        fi

        commands+=("$cmd")
        repeat_counts+=("$repeat_count")
    done
}

# Hàm hiển thị danh sách lệnh
function display_commands() {
    echo "###################################"
    echo "Các câu lệnh sẽ thực thi là:"
    for i in "${!commands[@]}"; do
        echo "- Lệnh: ${commands[$i]} (Thực hiện: ${repeat_counts[$i]} lần)"
    done
    echo "###################################"
}

# Hàm thực thi tất cả các lệnh song song
function execute_commands() {
    # Tạo danh sách các lệnh cần thực thi (bao gồm cả số lần lặp lại)
    cmd_list=()
    for i in "${!commands[@]}"; do
        local cmd="${commands[$i]}"
        local repeat_count="${repeat_counts[$i]}"
        
        # Lặp lại lệnh nếu cần thiết
        for ((j = 1; j <= repeat_count; j++)); do
            cmd_list+=("$cmd")
        done
    done
    
    # Chạy tất cả các lệnh song song với xargs
    printf "%s\n" "${cmd_list[@]}" | xargs -I CMD -P $count bash -c 'CMD'
    echo "Tất cả lệnh đã được thực thi song song."
}

# Hàm tùy chọn quét bảo mật với nmap
function security_scan() {
    echo "Bạn có muốn quét bảo mật với nmap không? (y/n)"
    read -r nmap_option

    if [[ "$nmap_option" == "y" ]]; then
        echo "Nhập địa chỉ IP hoặc tên miền để quét bảo mật với nmap:"
        read -r target
        echo "Đang quét bảo mật trên $target..."
        nmap -A "$target"
        echo "Kết quả quét bảo mật đã được hiển thị."
    fi
}

# Main script
display_intro
check_system_load
check_firewall
get_command_count
get_commands "$count"
display_commands
execute_commands
security_scan
