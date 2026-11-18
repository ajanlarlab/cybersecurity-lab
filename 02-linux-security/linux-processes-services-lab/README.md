
# Lab 04 — Linux Processes, Services & Network Security

**Category:** Linux Security / Blue Team Fundamentals
**Environment:** Ubuntu 26.04.1 LTS (WSL2)
**Tools:** ps, systemctl, ss, journalctl
**Lab Date:** November 16, 2026
**Status:** Completed

---

## English

### 1. Objective

The objective of this laboratory is to investigate Linux processes, running system services, listening network sockets, and system logs from a defensive security perspective.

### 2. Lab Environment

- Operating System: Ubuntu 26.04.1 LTS
- Platform: Windows Subsystem for Linux 2
- Analysis Type: Local system security investigation
- Security Focus: Blue Team / SOC Fundamentals

### 3. Process Analysis

Running Linux processes were examined using:

```bash
ps aux
```

Selected observations:

| PID | Process | Function |
|---|---|---|
| 1 | init | System initialization |
| 47 | systemd-journald | System logging |
| 79 | systemd-resolved | DNS resolution |
| 107 | cron | Scheduled tasks |
| 124 | networkd-dispatcher | Network events |
| 143 | snapd | Snap package management |
| 153 | systemd-logind | Session management |

Process ownership, CPU usage, memory usage, and executed commands were examined.

### 4. Running Services

Active system services were listed using:

```bash
systemctl --type=service --state=running --no-pager
```

A total of 12 running services were identified.

Selected services:

- chrony.service
- cron.service
- dbus.service
- rsyslog.service
- systemd-journald.service
- systemd-resolved.service
- systemd-logind.service
- unattended-upgrades.service

The observed services were consistent with expected Ubuntu functionality.

### 5. Network Socket Analysis

Listening TCP and UDP sockets were investigated using:

```bash
sudo ss -tulnp
```

| Protocol | Port | Process | Binding |
|---|---|---|---|
| TCP | 53 | systemd-resolved | Loopback |
| UDP | 53 | systemd-resolved | Loopback |
| UDP | 323 | chronyd | Loopback |
| TCP/UDP | 53 | Not identified | Private IPv4 address |

The unidentified DNS socket requires further investigation before attribution to a specific WSL component.

No public-facing listening address was established from the inspected output.

### 6. DNS Service Investigation

The DNS resolver service was examined using:

```bash
systemctl status systemd-resolved --no-pager
```

Observed results:

- Service State: Active (running)
- Startup Configuration: Enabled
- Main PID: 79
- Memory Usage: 4.9 MB
- Executable: /usr/lib/systemd/systemd-resolved

The process ID matched the process identified during network socket analysis.

This established a relationship between network sockets, processes, and system services.

### 7. System Log Analysis

DNS service logs were examined using:

```bash
sudo journalctl -u systemd-resolved -n 15 --no-pager
```

Observed events:

| Event | Time |
|---|---|
| Service stopped successfully | 19:02:33 |
| Service started | 19:49:20 |
| Clock change and cache flush | 20:45:05 |
| Clock change and cache flush | 20:51:07 |

Additional observations:

- A boot boundary was present in the journal.
- DNSSEC trust anchor information was recorded.
- Clock changes triggered DNS cache flushing.
- No explicit service failure was identified in the inspected log entries.

### 8. Security Findings

- Running processes and services were successfully enumerated.
- DNS-related network sockets were associated with systemd-resolved.
- Loopback bindings were identified.
- Service lifecycle events were examined.
- No confirmed evidence of malicious activity was established from the inspected data.

A limited process and log review does not establish that the entire system is secure.

### 9. Conclusion

This laboratory demonstrated practical Linux process investigation, service enumeration, network socket analysis, and basic log analysis.

These skills provide a foundation for SOC monitoring, incident investigation, and Linux security auditing.

---

## Türkçe

### 1. Amaç

Bu laboratuvarın amacı Linux sistemlerinde çalışan süreçleri, servisleri, ağ soketlerini ve sistem günlüklerini savunma güvenliği bakış açısıyla incelemektir.

### 2. Laboratuvar Ortamı

- İşletim Sistemi: Ubuntu 26.04.1 LTS
- Platform: WSL2
- Analiz Türü: Yerel sistem güvenlik incelemesi
- Güvenlik Alanı: Blue Team / SOC Temelleri

### 3. Süreç Analizi

Çalışan Linux süreçleri aşağıdaki komutla incelendi:

```bash
ps aux
```

İncelenen bazı süreçler:

| PID | Süreç | Görevi |
|---|---|---|
| 1 | init | Sistem başlatma |
| 47 | systemd-journald | Sistem günlükleri |
| 79 | systemd-resolved | DNS çözümleme |
| 107 | cron | Zamanlanmış görevler |
| 124 | networkd-dispatcher | Ağ olayları |
| 143 | snapd | Paket yönetimi |
| 153 | systemd-logind | Oturum yönetimi |

Süreçlerin kullanıcıları, işlem kimlikleri, CPU ve bellek kullanımları incelendi.

### 4. Servis Analizi

Çalışan servisler listelendi:

```bash
systemctl --type=service --state=running --no-pager
```

Toplam 12 aktif servis tespit edildi.

İncelenen servislerin Ubuntu sisteminin beklenen işlevleriyle uyumlu olduğu gözlemlendi.

### 5. Ağ Soketi Analizi

TCP ve UDP soketleri incelendi:

```bash
sudo ss -tulnp
```

| Protokol | Port | Süreç |
|---|---|---|
| TCP | 53 | systemd-resolved |
| UDP | 53 | systemd-resolved |
| UDP | 323 | chronyd |
| TCP/UDP | 53 | Henüz doğrulanmadı |

Loopback adreslerine bağlı servisler tespit edildi.

Sahibi belirlenemeyen DNS soketinin hangi WSL bileşenine ait olduğu ek araştırma gerektirmektedir.

### 6. DNS Servisi İncelemesi

```bash
systemctl status systemd-resolved --no-pager
```

Elde edilen bulgular:

- Servis durumu: Aktif
- Başlangıç yapılandırması: Etkin
- Ana işlem kimliği: 79
- Bellek kullanımı: 4,9 MB
- Çalıştırılan dosya: /usr/lib/systemd/systemd-resolved

Ağ analizinde tespit edilen PID ile servis PID değerinin eşleştiği doğrulandı.

### 7. Sistem Günlüğü Analizi

```bash
sudo journalctl -u systemd-resolved -n 15 --no-pager
```

İncelenen olaylar:

| Olay | Saat |
|---|---|
| Servisin başarıyla durdurulması | 19:02:33 |
| Servisin başlatılması | 19:49:20 |
| Saat değişikliği ve önbellek temizliği | 20:45:05 |
| Saat değişikliği ve önbellek temizliği | 20:51:07 |

Günlüklerde farklı sistem açılışlarına ait kayıtlar bulundu.

DNSSEC güven çapaları ve sistem saati değişikliklerine bağlı DNS önbellek temizleme olayları gözlemlendi.

### 8. Güvenlik Bulguları

- Linux süreçleri ve servisleri başarıyla listelendi.
- DNS portları ilgili süreçle eşleştirildi.
- Yerel ağ soketleri incelendi.
- Servis başlatma ve durdurma olayları analiz edildi.
- İncelenen verilerde doğrulanmış bir saldırı kanıtı bulunmadı.

Bu sınırlı inceleme, sistemin tamamen güvenli olduğunu kanıtlamaz.

### 9. Sonuç

Bu laboratuvarda Linux süreçleri, servisleri, ağ soketleri ve sistem günlükleri uygulamalı olarak analiz edildi.

SOC analizi, olay inceleme ve Linux sistem güvenliği alanlarında temel deneyim kazanıldı.

---

## Limitations | Sınırlamalar

- Process IDs may change after a system restart.
- The investigation covers the local WSL2 environment only.
- External network accessibility was not tested.
- No complete malware investigation was performed.

## Ethics & Privacy | Etik ve Gizlilik

All activities were performed in an authorized local environment.

Tüm çalışmalar kişisel ve yetkilendirilmiş laboratuvar ortamında gerçekleştirilmiştir.

Sensitive logs, credentials, private network addresses, and unique system identifiers are not published.
