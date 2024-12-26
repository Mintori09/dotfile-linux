#!/bin/bash
# Tự động chuyển về tiếng Anh sau khi không có đầu vào

# Kiểm tra thời gian không có hoạt động trong 5 giây
while true; do
    sleep 5
    # Sử dụng xdotool để thay đổi ngôn ngữ (sử dụng phím chuyển ngữ default Super + Space)
    xdotool key --clearmodifiers "Super+Space"
done
