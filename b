
        [
        [
        ]
        ],
      ],
      ],
      ],
      ],
      },
    {
    {
    {
    {
    }
    }
    }
    },
  ],
  ],
  ],
  }
{
}
          "2"
          "2048"
    "autounattend": "./answer_files/7/Autounattend.xml",
      "boot_wait": "2m",
      "boot_wait": "2m",
  "builders": [
          "--cpus",
      "disk_size": 61440,
      "disk_size": 61440,
      "execute_command": "{{.Vars}} cmd /c C:/Windows/Temp/script.bat",
      "floppy_files": [
      "floppy_files": [
      "guest_additions_path": "VBoxGuestAdditions_{{.Version}}.iso",
      "guest_additions_sha256": "a6f20f5b8ec11ae127ae48bcb19c20de488d38dbf807a8608a6468da7353a9a8",
      "guest_additions_url": "iso/VBoxGuestAdditions_{{.Version}}.iso",
      "guest_os_type": "windows7-64",
      "guest_os_type": "Windows7_64",
      "headless": false,
      "headless": false,
    "iso_checksum": "1d0d239a252cb53e466d39e752b17c28",
    "iso_checksum_type": "md5",
      "iso_checksum_type": "{{user `iso_checksum_type`}}",
      "iso_checksum_type": "{{user `iso_checksum_type`}}",
      "iso_checksum": "{{user `iso_checksum`}}",
      "iso_checksum": "{{user `iso_checksum`}}",
    "iso_url": "iso/windows7.iso"
      "iso_url": "{{user `iso_url`}}",
      "iso_url": "{{user `iso_url`}}",
      "keep_input_artifact": false,
          "--memory",
        "memsize": "2048",
          "modifyvm",
          "modifyvm",
          "{{.Name}}",
          "{{.Name}}",
        "numvcpus": "2",
      "output": "windows_7_{{.Provider}}.box",
  "post-processors": [
  "provisioners": [
        "RemoteDisplay.vnc.enabled": "false",
        "RemoteDisplay.vnc.port": "5900",
      "remote_path": "/tmp/script.bat",
      "scripts": [
        "./scripts/compact.bat"
        "./scripts/compile-dotnet-assemblies.bat",
        "./scripts/disable-auto-logon.bat",
        "./scripts/dis-updates.ps1",
        "./scripts/dis-updates.ps1",
        "./scripts/enable-rdp.bat",
        "./scripts/hotfix-KB3102810.bat",
        "./scripts/hotfix-KB3102810.bat",
        "./scripts/microsoft-updates.bat",
        "./scripts/microsoft-updates.bat",
        "./scripts/openssh.ps1"
        "./scripts/openssh.ps1",
        "./scripts/oracle-cert.cer"
        "./scripts/vagrant-ssh.bat",
        "./scripts/vm-guest-tools.bat",
        "./scripts/win-updates.ps1",
        "./scripts/win-updates.ps1",
        "scsi0.virtualDev": "lsisas1068"
      "shutdown_command": "shutdown /s /t 10 /f /d p:4:1 /c \"Packer Shutdown\"",
      "shutdown_command": "shutdown /s /t 10 /f /d p:4:1 /c \"Packer Shutdown\"",
      "ssh_password": "vagrant",
      "ssh_password": "vagrant",
      "ssh_username": "vagrant",
      "ssh_username": "vagrant",
      "ssh_wait_timeout": "8h",
      "ssh_wait_timeout": "8h",
      "tools_upload_flavor": "windows",
      "type": "shell"
      "type": "vagrant",
      "type": "virtualbox-iso",
      "type": "vmware-iso",
        "{{user `autounattend`}}",
        "{{user `autounattend`}}",
      "vagrantfile_template": "vagrantfile-windows_7.template"
  "variables": {
      "vboxmanage": [
      "virtualbox_version_file": ".vbox_version"
      "vmx_data": {
      "vnc_port_max": 5980,
      "vnc_port_min": 5900
