
# Lab 02 — TCP & UDP Network Analysis

**Category:** Networking / Blue Team Fundamentals  
**Environment:** Windows 11  
**Tools:** PowerShell, Wireshark 4.6.9  
**Status:** Completed

---

## English

### 1. Objective

The objective of this laboratory is to understand TCP and UDP communication, identify listening ports and their associated processes, and analyze a TCP three-way handshake using Wireshark.

### 2. TCP Port Investigation

Windows PowerShell was used to enumerate listening TCP ports.

```powershell
Get-NetTCPConnection -State Listen |
Select-Object LocalAddress, LocalPort, State, OwningProcess |
Sort-Object LocalPort
```

Selected findings:

| Port | Process / Service |
|---|---|
| 5678 | Docker Desktop Backend |
| 5040 | Connected Devices Platform Service (CDPSvc) |
| 7680 | Delivery Optimization (DoSvc) |
| 5939 | TeamViewer_Service |

The processes were identified using Get-Process and Get-CimInstance.

These findings alone do not indicate malicious activity.

### 3. TCP Three-Way Handshake

A TCP connection to example.com on port 80 was tested using:

```powershell
Test-NetConnection example.com -Port 80
```

Result: TCP connection successful over IPv6.

Wireshark captured the following packets:

| Frame | Source Port | Destination Port | TCP Flags | Relative SEQ | Relative ACK |
|---|---|---|---|---|---|
| 1388 | 61825 | 80 | SYN | 0 | 0 |
| 1389 | 80 | 61825 | SYN, ACK | 0 | 1 |
| 1390 | 61825 | 80 | ACK | 1 | 1 |

TCP stream index: 45

The connection was successfully established through the SYN, SYN-ACK, and ACK exchange.

### 4. UDP Analysis

A DNS query was generated using:

```powershell
nslookup -type=A example.com 192.168.1.1
```

Wireshark UDP packet findings:

| Field | Value |
|---|---|
| Source Port | 51239 |
| Destination Port | 53 |
| UDP Length | 37 bytes |
| UDP Header | 8 bytes |
| UDP Payload | 29 bytes |
| Checksum | 0x8432 |
| Checksum Status | Unverified |

The captured packet demonstrates DNS communication over UDP without a TCP-style connection handshake.

### 5. Security Findings

- Listening TCP ports were associated with identifiable Windows services and applications.
- TCP connection establishment was verified through the three-way handshake.
- A UDP DNS query was captured and examined.
- No evidence of malicious activity was established from the analyzed packets.

### 6. Conclusion

This laboratory provided practical experience in TCP and UDP traffic analysis, process identification, network troubleshooting, and packet inspection.

---

## Türkçe

### 1. Amaç

Bu laboratuvarın amacı TCP ve UDP protokollerini öğrenmek, bilgisayarda dinleme durumundaki portları ve ilgili işlemleri tespit etmek ve Wireshark ile TCP üç yönlü el sıkışma işlemini analiz etmektir.

### 2. TCP Port Analizi

Windows PowerShell üzerinden dinleme durumundaki TCP portları listelendi.

```powershell
Get-NetTCPConnection -State Listen |
Select-Object LocalAddress, LocalPort, State, OwningProcess |
Sort-Object LocalPort
```

Tespit edilen bazı hizmetler:

| Port | Uygulama / Hizmet |
|---|---|
| 5678 | Docker Desktop Backend |
| 5040 | Bağlı Cihazlar Platformu Hizmeti |
| 7680 | Teslim En İyileştirme Hizmeti |
| 5939 | TeamViewer_Service |

İşlemler Get-Process ve Get-CimInstance komutlarıyla doğrulandı.

Bu bulgular tek başına zararlı faaliyet göstergesi değildir.

### 3. TCP Üç Yönlü El Sıkışma

example.com adresinin 80 numaralı TCP portuna bağlantı testi gerçekleştirildi.

```powershell
Test-NetConnection example.com -Port 80
```

Sonuç: IPv6 üzerinden TCP bağlantısı başarılı.

Wireshark üzerinde aşağıdaki paketler yakalandı:

| Paket | Kaynak Port | Hedef Port | Bayrak |
|---|---|---|---|
| 1388 | 61825 | 80 | SYN |
| 1389 | 80 | 61825 | SYN-ACK |
| 1390 | 61825 | 80 | ACK |

TCP akış numarası: 45

İstemci ve sunucu arasında TCP bağlantısının üç aşamada kurulduğu doğrulandı.

### 4. UDP Analizi

PowerShell kullanılarak DNS sorgusu oluşturuldu:

```powershell
nslookup -type=A example.com 192.168.1.1
```

Wireshark üzerinde incelenen UDP paketinin özellikleri:

| Alan | Değer |
|---|---|
| Kaynak Port | 51239 |
| Hedef Port | 53 |
| UDP Uzunluğu | 37 byte |
| UDP Başlığı | 8 byte |
| Veri Boyutu | 29 byte |
| Checksum | 0x8432 |
| Checksum Durumu | Doğrulanmadı |

UDP protokolünün TCP'deki gibi üç yönlü el sıkışma gerçekleştirmediği incelendi.

### 5. Güvenlik Değerlendirmesi

- Dinleme durumundaki TCP portları incelendi.
- Portların ilişkili olduğu Windows hizmetleri ve uygulamalar belirlendi.
- TCP bağlantısının kurulma aşamaları analiz edildi.
- UDP üzerinden DNS sorgusu gözlemlendi.
- İncelenen verilerde zararlı faaliyet gerçekleştiğine ilişkin kanıt elde edilmedi.

### 6. Sonuç

Bu laboratuvar sayesinde TCP ve UDP protokolleri, port analizi, işlem kimliği eşleştirmesi ve ağ paketi inceleme konularında uygulamalı deneyim kazanıldı.

---

## Ethics and Privacy | Etik ve Gizlilik

All activities were conducted in an authorized environment.

Tüm çalışmalar yetkili ortamda gerçekleştirilmiştir.

Raw packet captures, credentials and sensitive personal information are not published.
