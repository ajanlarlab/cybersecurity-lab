
# Lab 03 — Linux File Permissions & Ownership

**Category:** Linux Security / Blue Team Fundamentals  
**Environment:** Ubuntu 26.04.1 LTS (WSL2)  
**Tools:** Linux Terminal, chmod, chown, sudo  
**Status:** Completed

---

## English

### 1. Objective

The objective of this laboratory is to understand Linux user identities, file ownership, access permissions, and the principle of least privilege through hands-on exercises.

### 2. Lab Environment

- Operating System: Ubuntu 26.04.1 LTS
- Platform: Windows Subsystem for Linux 2
- User Account: Standard user with sudo privileges
- Test Directory: ~/cybersecurity-lab03

All tests were performed using locally created test files.

### 3. User and Group Investigation

The following commands were used:

```bash
whoami
id
pwd
```

Results:

- UID: 1000
- GID: 1000
- User belongs to the sudo group.
- The user operated with standard privileges unless sudo was explicitly used.

### 4. File Permission Analysis

A test file was created:

```bash
echo "Linux Security Lab 03" > test.txt
ls -l test.txt
```

Initial permissions:

```text
-rw-r--r--
```

The permissions were changed using:

```bash
chmod 600 test.txt
```

Updated permissions:

```text
-rw-------
```

The file owner retained read and write permissions, while group and other permissions were removed.

### 5. File Ownership Analysis

A second test file was created:

```bash
echo "Ownership Security Test" > ownership.txt
sudo chown root:root ownership.txt
```

The ownership was successfully changed to root.

### 6. Access Control Testing

Initial permissions were 644.

The standard user could read the file but could not append data to it.

```bash
cat ownership.txt
echo "Unauthorized write test" >> ownership.txt
```

Result:

```text
Permission denied
```

The permissions were then restricted:

```bash
sudo chmod 600 ownership.txt
```

A standard user attempted to read the file:

```bash
cat ownership.txt
```

Result:

```text
Permission denied
```

The file was successfully accessed with elevated privileges:

```bash
sudo cat ownership.txt
```

Result:

```text
Ownership Security Test
```

### 7. Security Findings

- Linux file permissions control read, write, and execute access.
- File ownership and file permissions are separate security mechanisms.
- Changing ownership to root does not automatically prevent read access by other users.
- Permissions set to 600 restrict ordinary access to the file owner.
- Elevated privileges enabled access to the protected file.
- The exercises demonstrated the principle of least privilege.

### 8. Conclusion

This laboratory demonstrated Linux discretionary access controls, file ownership management, and permission enforcement through practical testing.

---

## Türkçe

### 1. Amaç

Bu laboratuvarın amacı Linux kullanıcı kimliklerini, dosya sahipliğini, erişim izinlerini ve en az ayrıcalık ilkesini uygulamalı olarak öğrenmektir.

### 2. Laboratuvar Ortamı

- İşletim Sistemi: Ubuntu 26.04.1 LTS
- Platform: WSL2
- Kullanıcı: sudo grubuna üye normal kullanıcı
- Test Dizini: ~/cybersecurity-lab03

Tüm testler yerel ortamda oluşturulan örnek dosyalar üzerinde gerçekleştirildi.

### 3. Kullanıcı ve Grup Analizi

Kullanılan komutlar:

```bash
whoami
id
pwd
```

Elde edilen bulgular:

- Kullanıcı kimliği (UID): 1000
- Grup kimliği (GID): 1000
- Kullanıcı sudo grubunun üyesidir.
- sudo kullanılmadığında işlemler normal kullanıcı yetkileriyle gerçekleştirilmiştir.

### 4. Dosya İzinleri Analizi

Test dosyası oluşturuldu:

```bash
echo "Linux Security Lab 03" > test.txt
ls -l test.txt
```

Başlangıç izinleri:

```text
-rw-r--r--
```

İzinler değiştirildi:

```bash
chmod 600 test.txt
```

Yeni izinler:

```text
-rw-------
```

Böylece dosya sahibi okuma ve yazma yetkilerini korurken grup ve diğer kullanıcıların erişim izinleri kaldırıldı.

### 5. Dosya Sahipliği Analizi

İkinci test dosyası oluşturuldu:

```bash
echo "Ownership Security Test" > ownership.txt
sudo chown root:root ownership.txt
```

Dosyanın sahibi ve grubu başarıyla root olarak değiştirildi.

### 6. Erişim Kontrolü Testleri

Dosyanın izinleri başlangıçta 644 olarak ayarlanmıştı.

Normal kullanıcı dosyayı okuyabildi ancak dosyaya yazamadı.

```bash
cat ownership.txt
echo "Unauthorized write test" >> ownership.txt
```

Sonuç:

```text
Permission denied
```

Ardından erişim izinleri kısıtlandı:

```bash
sudo chmod 600 ownership.txt
```

Normal kullanıcıyla okuma denemesi:

```bash
cat ownership.txt
```

Sonuç:

```text
Permission denied
```

Yönetici yetkisiyle okuma denemesi:

```bash
sudo cat ownership.txt
```

Sonuç:

```text
Ownership Security Test
```

### 7. Güvenlik Bulguları

- Linux dosya izinleri okuma, yazma ve çalıştırma erişimlerini kontrol eder.
- Dosya sahipliği ile erişim izinleri birbirinden farklıdır.
- Sahipliği root yapmak tek başına diğer kullanıcıların okuma erişimini kaldırmaz.
- 600 izniyle normal erişim dosya sahibiyle sınırlandırılır.
- Yönetici yetkisiyle korunan dosyaya erişim sağlanabildi.
- En az ayrıcalık ilkesinin temel uygulamaları incelendi.

### 8. Sonuç

Bu laboratuvarda Linux dosya sahipliği, erişim kontrolü, chmod, chown ve sudo komutları gerçek test ortamında uygulanarak incelendi.

---

## Ethics & Security

All exercises were performed in an authorized local laboratory.

Tüm çalışmalar kişisel ve yetkili laboratuvar ortamında gerçekleştirilmiştir.

No credentials, sensitive files, or private system information are published.
