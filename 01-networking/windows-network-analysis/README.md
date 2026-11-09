
# Lab 01 — Windows Network Analysis

## English

### Objective
Analyze network configuration, ICMP connectivity, and DNS traffic using Windows PowerShell and Wireshark.

### Lab Environment
- Operating System: Windows 11
- Tools: PowerShell, Wireshark 4.6.9, Npcap
- Network Interface: Ethernet
- Testing Scope: Personal authorized network

### Network Analysis
- Examined IPv4 configuration and default gateways.
- Tested local gateway connectivity with ICMP.
- Used nslookup to investigate DNS resolution.
- Captured and filtered Ethernet traffic with Wireshark.

### ICMP Test
- Target: Local network gateway
- Packets sent: 4
- Packets received: 4
- Packet loss: 0%
- Round-trip time: 1–2 ms

### DNS Packet Analysis
- Domain: chatgpt.com
- Record Type: A
- Transaction ID: 0x7e73
- Query Frame: 794
- Response Frame: 798
- Response Flags: 0x8180
- Response Status: No error
- Answer Records: 2
- Response Time: 2.8695 ms

### Findings
The DNS query and response were matched using their transaction ID. The response contained two IPv4 address records. No DNS protocol error was observed in this transaction.

## Türkçe

### Amaç
Windows PowerShell ve Wireshark kullanarak ağ yapılandırmasını, ICMP bağlantısını ve DNS trafiğini incelemek.

### Laboratuvar Ortamı
- İşletim Sistemi: Windows 11
- Araçlar: PowerShell, Wireshark 4.6.9, Npcap
- Ağ Bağdaştırıcısı: Ethernet
- Test Kapsamı: Kişisel ve yetkili ağ

### Ağ Analizi
- IPv4 yapılandırması ve varsayılan ağ geçitleri incelendi.
- ICMP ile yerel ağ geçidi bağlantısı test edildi.
- nslookup ile DNS çözümlemesi gerçekleştirildi.
- Wireshark ile Ethernet trafiği yakalandı ve filtrelendi.

### ICMP Testi
- Hedef: Yerel ağ geçidi
- Gönderilen paket: 4
- Alınan paket: 4
- Paket kaybı: %0
- Gecikme: 1–2 ms

### DNS Paket Analizi
- Alan adı: chatgpt.com
- Kayıt türü: A
- İşlem kimliği: 0x7e73
- Sorgu paketi: 794
- Yanıt paketi: 798
- Yanıt bayrakları: 0x8180
- Yanıt durumu: Hata yok
- Yanıt kaydı: 2
- Yanıt süresi: 2,8695 ms

### Sonuç
DNS sorgu ve yanıt paketleri işlem kimliği kullanılarak eşleştirildi. DNS sunucusu iki IPv4 adresi döndürdü. İncelenen DNS işleminde protokol hatası gözlemlenmedi.

## Security & Privacy
All tests were performed in an authorized environment. Raw packet captures and sensitive information are not published.

## Status
Completed / Tamamlandı
  