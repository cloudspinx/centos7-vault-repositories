# CentOS 7 Vault Repositories (End-of-Life - Limited Use)

This repository contains `.repo` files for the CentOS 7 Vault repositories.

Important Note:

> CentOS 7 reached its end-of-life (EOL) on December 31, 2021. These vault repositories provide limited access to critical security updates for a short grace period only. They are not intended as a long-term solution.

This repository is intended for:

- **Informational purposes**: See the structure and content of the CentOS 7 vault repositories.
- **Emergency situations**: Potentially address critical security vulnerabilities on a system that cannot be migrated immediately.

**Warning**:
> Using these repositories for ongoing use is strongly discouraged due to limited availability and lack of future updates. It is highly recommended to migrate to a supported alternative like Rocky Linux or AlmaLinux for continued security and stability.

## How to use the scripts

We have created two scripts that are used to generate and enable or disable repositories.

1. `generate_base_repos.sh`: Use this to generate repositories in `.repo`.
2. `enable_repos.sh`: Use this to enable or disable repositories

Step 1: Clone the repository

```bash
git clone https://github.com/cloudspinx/centos7-vault-repositories.git
```

Step 2: Navigate into the `centos7-vault-repositories` directory:

```bash
cd centos7-vault-repositories
```

Step 3: Run script to generate key vault repositories:

```bash
bash generate_base_repos.sh
```
See example output:

```bash
Created centos7_repos/atomic.repo
Created centos7_repos/centosplus.repo
Created centos7_repos/dotnet.repo
Created centos7_repos/extras.repo
Created centos7_repos/fasttrack.repo
Created centos7_repos/os.repo
Created centos7_repos/rt.repo
Created centos7_repos/updates.repo
Generated .repo files for all repositories in centos7_repos.
```

Step 4: Run script to enable or disable vault repos. Choose ones to enable and ones to disable accordingly.

```bash
bash enable_repos.sh
```

See example:
```bash
Do you want to enable repository 'atomic' (y/n)? n
Disabled repository 'atomic'.
Do you want to enable repository 'centosplus' (y/n)? y
Enabled repository 'centosplus'.
Do you want to enable repository 'dotnet' (y/n)? n
Disabled repository 'dotnet'.
Do you want to enable repository 'extras' (y/n)? y
Enabled repository 'extras'.
Do you want to enable repository 'fasttrack' (y/n)? y
Enabled repository 'fasttrack'.
Do you want to enable repository 'os' (y/n)? y
Enabled repository 'os'.
Do you want to enable repository 'rt' (y/n)? n
Disabled repository 'rt'.
Do you want to enable repository 'updates' (y/n)? y
Enabled repository 'updates'.
Repository enablement process completed.
```

Step 5: Backup current repositories

```bash
mkdir ~/repos_backup
sudo mv /etc/yum.repos.d/* ~/repos_backup
```

Step 6: Copy generated repository files to ` /etc/yum.repos.d/`

```bash
sudo cp -r centos7_repos/* /etc/yum.repos.d/
```

Clean yum cache

```bash
$ sudo yum clean all
Loaded plugins: fastestmirror
Cleaning repos: atomic centosplus dotnet extras fasttrack os rt updates
Cleaning up list of fastest mirrors
```

Update packages cache

```bash
sudo yum makecache fast
```

Show list of repositories

```bash
$ sudo  yum repolist
Loaded plugins: fastestmirror
Loading mirror speeds from cached hostfile
repo id                                                                                        repo name                                                                                        status
atomic/7/x86_64                                                                                CentOS-7 - atomic                                                                                   137
centosplus/7/x86_64                                                                            CentOS-7 - centosplus                                                                               277
dotnet/7/x86_64                                                                                CentOS-7 - dotnet                                                                                   395
extras/7/x86_64                                                                                CentOS-7 - extras                                                                                   526
fasttrack/7/x86_64                                                                             CentOS-7 - fasttrack                                                                                 44
os/7/x86_64                                                                                    CentOS-7 - os                                                                                    10,072
rt/7/x86_64                                                                                    CentOS-7 - rt                                                                                       227
updates/7/x86_64                                                                               CentOS-7 - updates                                                                                6,173
repolist: 17,851
```

This confirms the vault repositories configured on CentOS 7 system are working.


