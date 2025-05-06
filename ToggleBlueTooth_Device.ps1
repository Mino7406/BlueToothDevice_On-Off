
# 지정하고 싶은 기기 MAC 주소 입력란
$mac = "여기에 입력"

# 현재 연결된 블루투스 장치 목록에서 해당 MAC 주소를 포함한 장치 확인
$connected = Get-PnpDevice | Where-Object {
    $_.InstanceId -like "*$mac*" -and $_.Status -eq "OK"
}

# 연결 상태에 따라 블루투스 장치를 해제 또는 재연결
if ($connected) {
    Write-Output "Connected: Trying to disconnect..."
    Disable-PnpDevice -InstanceId $connected.InstanceId -Confirm:$false
} else {
    Write-Output "Unconnected: Trying to connect..."
    $device = Get-PnpDevice | Where-Object { $_.InstanceId -like "*$mac*" }
    if ($device) {
        Enable-PnpDevice -InstanceId $device.InstanceId -Confirm:$false
    } else {
        Write-Output "Device not found."
    }
}
