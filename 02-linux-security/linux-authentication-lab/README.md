
# Lab 05 — Linux Authentication & Security Log Analysis

## Linux Authentication Monitor v1.0.0

**Category:** Blue Team / SOC / Security Automation  
**Language:** Bash  
**Environment:** Ubuntu 26.04.1 LTS (WSL2)  
**Date:** November 18, 2026  
**Status:** Initial release

---

## English

### 1. Objective

The objective of this laboratory is to investigate Linux authentication logs, detect failed sudo authentication events, and develop a Bash-based security monitoring tool.

### 2. Tools

- Ubuntu Linux / WSL2
- Bash
- journalctl
- grep
- sudo
- Visual Studio Code
- Git and GitHub

### 3. Authentication Log Investigation

Recent sudo logs were examined using:

```bash
sudo journalctl _COMM=sudo -n 20 --no-pager
```

Failed authentication records were filtered using:

```bash
sudo journalctl _COMM=sudo --no-pager | grep -i "authentication failure"
```

Matching records were counted using:

```bash
sudo journalctl _COMM=sudo --no-pager | grep -ic "authentication failure"
```

### 4. Historical Security Events

| Date | Time | Event |
|---|---|---|
| 2026-11-16 | 18:09:56 | Authentication failure |
| 2026-11-18 | 19:25:25 | Controlled authentication failure |

The first event was associated with an earlier laboratory exercise. The second event was intentionally generated for detection testing.

Neither event established evidence of an actual attack.

### 5. Controlled Security Event

The cached sudo authentication was invalidated:

```bash
sudo -k
sudo -v
```

A single incorrect password was entered, followed by the correct password.

The new authentication failure was detected using:

```bash
sudo journalctl _COMM=sudo --since "10 minutes ago" --no-pager | grep -i "authentication failure"
```

### 6. Security Tool Development

A Bash-based authentication monitor was developed.

File:

`auth-monitor.sh`

Features:

- Reads sudo authentication logs.
- Analyzes the previous 10 minutes.
- Counts matching authentication failure records.
- Generates threshold-based security alerts.
- Handles log-reading and analysis errors.
- Displays analysis date and results.

### 7. Detection Rules

| Matching Records | Alert Level |
|---|---|
| 0 | NORMAL |
| 1–2 | WARNING |
| 3 or more | HIGH |
| Command failure | ERROR |

The thresholds are educational and require environment-specific tuning before production use.

### 8. Usage

Run from the repository root:

```bash
bash 02-linux-security/linux-authentication-lab/auth-monitor.sh
```

Syntax validation:

```bash
bash -n 02-linux-security/linux-authentication-lab/auth-monitor.sh
```

### 9. Test Results

| Test | Method | Result |
|---|---|---|
| Syntax | bash -n | Passed |
| NORMAL | Live journal data | Passed |
| WARNING | Live journal data | Passed |
| HIGH | Simulated count | Passed |
| ERROR | Simulated command failure | Passed |

HIGH and ERROR were tested as isolated logic simulations, not complete end-to-end application tests.

### 10. Security Findings

- Historical authentication failures were identified.
- A controlled authentication failure was generated and detected.
- Authentication records were filtered by time.
- A threshold-based detection algorithm was implemented.
- The tool successfully generated NORMAL and WARNING results using live logs.

### 11. Limitations

- The tool monitors sudo authentication records only.
- It performs a single analysis per execution.
- Continuous monitoring is not implemented.
- User-specific detection is not implemented.
- External notifications are not supported.
- Matching log records may not represent every individual authentication attempt.
- Zero matching records does not prove that a system is secure.
- Complete HIGH and ERROR integration tests remain pending.

### 12. Future Improvements

- Configurable detection thresholds
- User-based event analysis
- JSON and CSV reporting
- Automated testing
- Scheduled monitoring
- SIEM integration
- Python-based log analysis

---

## Türkçe

### 1. Amaç

Bu laboratuvarın amacı Linux kimlik doğrulama günlüklerini incelemek, başarısız sudo girişlerini tespit etmek ve Bash tabanlı bir güvenlik analiz aracı geliştirmektir.

### 2. Kullanılan Araçlar

- Ubuntu Linux / WSL2
- Bash
- journalctl
- grep
- sudo
- Visual Studio Code
- Git ve GitHub

### 3. Kimlik Doğrulama Analizi

Sudo günlükleri journalctl ile incelendi.

Başarısız kimlik doğrulama kayıtları grep kullanılarak filtrelendi ve sayıldı.

Geçmiş laboratuvar çalışmalarından kalan bir başarısız kimlik doğrulama kaydı tespit edildi.

### 4. Kontrollü Güvenlik Olayı

Sudo yetkilendirme önbelleği geçersiz kılındı.

Kontrollü olarak bir yanlış şifre girişi gerçekleştirildi.

Oluşturulan olay son 10 dakikalık kayıtlar içerisinde başarıyla tespit edildi.

### 5. Güvenlik Yazılımı

Linux Authentication Monitor isimli Bash tabanlı güvenlik aracı geliştirildi.

Yazılımın özellikleri:

- Sudo günlüklerini okuma
- Son 10 dakikayı analiz etme
- Başarısız doğrulama kayıtlarını sayma
- Alarm seviyesi belirleme
- Komut hatalarını değerlendirme
- Analiz sonuçlarını görüntüleme

### 6. Alarm Kuralları

| Kayıt Sayısı | Alarm |
|---|---|
| 0 | NORMAL |
| 1–2 | WARNING |
| 3 ve üzeri | HIGH |
| Komut hatası | ERROR |

Alarm eşikleri eğitim amacıyla belirlenmiştir.

### 7. Test Sonuçları

| Test | Yöntem | Sonuç |
|---|---|---|
| Sözdizimi | bash -n | Başarılı |
| NORMAL | Gerçek log verisi | Başarılı |
| WARNING | Gerçek log verisi | Başarılı |
| HIGH | Sentetik veri | Başarılı |
| ERROR | Hata simülasyonu | Başarılı |

HIGH ve ERROR testleri bağımsız koşul simülasyonlarıdır. Uçtan uca yazılım testleri henüz tamamlanmamıştır.

### 8. Güvenlik Bulguları

- Başarısız kimlik doğrulama kayıtları tespit edildi.
- Kontrollü bir güvenlik olayı oluşturuldu.
- Zaman aralığına göre log filtrelemesi yapıldı.
- Bash ile güvenlik alarm algoritması geliştirildi.
- Gerçek log verileri kullanılarak NORMAL ve WARNING alarm seviyeleri doğrulandı.

### 9. Sınırlamalar

- Yalnızca sudo kayıtları incelenmektedir.
- Sürekli izleme özelliği bulunmamaktadır.
- Kullanıcı bazlı analiz yapılmamaktadır.
- Otomatik bildirim özelliği bulunmamaktadır.
- Alarm bulunmaması sistemin güvenli olduğunu kanıtlamaz.

### 10. Gelecek Geliştirmeler

- Ayarlanabilir alarm eşikleri
- Kullanıcı bazlı analiz
- JSON ve CSV raporlama
- Otomatik yazılım testleri
- Zamanlanmış güvenlik kontrolleri
- SIEM entegrasyonu
- Python log analiz aracı

## Ethics & Privacy | Etik ve Gizlilik

All tests were conducted in a personal, authorized laboratory environment.

Tüm testler kişisel ve yetkilendirilmiş laboratuvar ortamında gerçekleştirildi.

No passwords, credentials or raw sensitive system logs are published.
