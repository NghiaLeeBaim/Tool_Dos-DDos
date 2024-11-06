### Ý Tưởng ###
Sử dụng các câu lệnh như ping hoặc nmap để tấn công Dos/DDos các trang website. Chỉ sử dụng các câu lệnh không cài đặt thêm bất cứ gì khác
=> Script chỉ thực hiện các lệnh 1 cách tự dộng

### Mục tiêu học hỏi, chia sẻ kiến thức ###

### Hướng dẫn sử dụng ###
1. Nhập số câu lệnh bạn muốn thực thi (có nghĩa là bạn sẽ nhập số câu lệnh mà bạn dùng cùng 1 lúc vd bạn nhập 2 thì bạn sẽ thực hiện 2 câu lệnh cùng 1 lúc như: ping google.com và nmap google.com)
2. Tiến hành nhập các câu lệnh theo số lượng đã nhập ở trên
3. Nhấn enter để thực hiện
=> Có thể dùng thêm proxy để ẩn danh

### tính năng phát triển ###
- Khi có 1 câu lệnh nhập thêm số lần thực hiện câu lệnh đó
- Tự động các lệnh scan
- Ghi lại log truy cập
- Cải tiến tính năng quản lý tài nguyên
- Khả năng quét bảo mật
- Cải tiến khả năng đa luồn
- Tính năng kiểm tra và bảo vệ hệ thống

### Ưu điểm / nhược điểm ###
1. Ưu điểm:
- Dễ hiểu code, đơn giản
- Có thể phát triển thêm nhiều tính năng
- Đa ứng dụng không chỉ Dos hay DDos
2. Nhược điểm:
- Pháp lý và Đạo đức
Tấn công DoS, DDoS (Distributed Denial of Service), hoặc bất kỳ hình thức tấn công mạng nào đều trái pháp luật ở hầu hết các quốc gia. Điều này có thể dẫn đến hậu quả pháp lý nghiêm trọng, bao gồm các khoản phạt lớn và thậm chí là án tù.
Các hành động này cũng vi phạm đạo đức và gây thiệt hại cho người khác, bao gồm cả tổ chức và cá nhân.
- Hiệu quả của Script và Công cụ
ping và nmap không phải là công cụ tối ưu cho DoS. ping chỉ có thể gửi các gói ICMP, nhưng nó bị giới hạn bởi nhiều yếu tố như giới hạn tốc độ mạng và các biện pháp bảo vệ của hệ thống mục tiêu (nhiều máy chủ sẽ tự động giới hạn hoặc chặn các yêu cầu ICMP từ các nguồn đáng ngờ).
nmap được thiết kế để quét mạng và kiểm tra các dịch vụ đang chạy chứ không phải để gây quá tải hệ thống.
Một script Bash thông thường sẽ không đủ khả năng tạo lưu lượng mạng lớn một cách nhanh chóng như các công cụ chuyên dụng cho DDoS (ví dụ: LOIC, HOIC).
- Hạn chế của Kịch bản Bash cho Tấn công Mạng
Hiệu suất không cao: Script Bash này dựa vào lặp lại các lệnh đồng thời, nhưng các lệnh này sẽ không thể tạo ra lượng lớn lưu lượng mạng cần thiết để thực hiện DoS hiệu quả.
Giới hạn tốc độ và tài nguyên: Máy tính của bạn sẽ nhanh chóng bị giới hạn bởi CPU, bộ nhớ, và mạng, dẫn đến quá tải trên chính thiết bị của bạn hơn là thiết bị mục tiêu.
- Biện pháp Phòng chống của Hệ thống Mục tiêu
Hầu hết các hệ thống máy chủ hiện đại đều có cơ chế phát hiện và ngăn chặn các cuộc tấn công DoS/DDoS. Ví dụ: hệ thống tường lửa sẽ tự động chặn các địa chỉ IP gửi quá nhiều yêu cầu trong một khoảng thời gian ngắn.
Các mạng CDN (Content Delivery Network) như Cloudflare và Akamai có khả năng giảm thiểu các cuộc tấn công DoS/DDoS, làm cho các cuộc tấn công từ một máy đơn lẻ trở nên vô hiệu.
- Tấn công DoS có ảnh hưởng tiêu cực
Tấn công DoS không chỉ gây ảnh hưởng xấu tới mục tiêu mà còn làm tiêu tốn tài nguyên và băng thông của bạn. Thậm chí nếu có đạt được mục tiêu, kết quả vẫn có thể dẫn đến hậu quả pháp lý nặng nề.
