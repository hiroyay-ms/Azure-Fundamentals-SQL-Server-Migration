

### 参考情報

- [名前付け規則を定義する](https://learn.microsoft.com/ja-jp/azure/cloud-adoption-framework/ready/azure-best-practices/resource-naming)

- [Azure リソースの種類に推奨される省略形](https://raw.githubusercontent.com/hiroyay-ms/AzureContainerApps-Hands-on-Lab-1/main/Before%20the%20HOL.md)

<br />

### 共通リソースの展開

<br />

[![Deploy to Azure](https://aka.ms/deploytoazurebutton)](https://raw.githubusercontent.com/hiroyay-ms/Azure-Fundamentals-SQL-Server-Migration/main/templates/deploy-vnet-hub.json)

### パラメーター

- **virtualNetwork**: 仮想ネットワーク名（2 ～ 64 文字/英数字、アンダースコア、ピリオド、およびハイフン）

- **addressPrefix**: IPv4 アドレス空間

- **subnet1**: サブネットの名前 (1)（1 ～ 80 文字/英数字、アンダースコア、ピリオド、およびハイフン）

- **subnet1Prefix**: サブネット アドレス範囲 (1)

- **bastionPrefix**: AzureBastionSubnet サブネットのアドレス範囲

- **bastionHost**: Bastion リソースの名前（1 ～ 80 文字/英数字、アンダースコア、ピリオド、およびハイフン）

※ 事前にリソース グループの作成が必要

※ 選択したリソース グループのリージョンにすべてのリソースを展開

<br />

### リソースの展開

<br />

[![Deploy to Azure](https://aka.ms/deploytoazurebutton)](https://raw.githubusercontent.com/hiroyay-ms/Azure-Fundamentals-SQL-Server-Migration/main/templates/deploy-resources.json)

### パラメーター

- **virtualNetwork**: 仮想ネットワーク名（2 ～ 64 文字/英数字、アンダースコア、ピリオド、およびハイフン）

- **addressPrefix**: IPv4 アドレス空間

- **subnet1**: サブネットの名前（1 ～ 80 文字/英数字、アンダースコア、ピリオド、およびハイフン）

- **subnet1Prefix**: サブネット アドレス範囲

- **networkSecurityGroup**: ネットワーク セキュリティ グループ名 (2 ～ 64 文字/英数字、アンダースコア、ピリオド、およびハイフン)

- **sqlServerName**: SQL Server 仮想マシン名 (15文字以下)

- **virtualMachineName**: Azure Data Studio 仮想マシン名 (15文字以下)

- **adminUserName**: 管理者アカウント名

- **adminPassword**: 管理者パスワード

- **machineSize**: 仮想マシン サイズ

※ 事前にリソース グループの作成が必要

※ 選択したリソース グループのリージョンにすべてのリソースを展開

※ 共通リソースで Bastion を展開した後は、リソース展開後に手動で VNet Peering を構成

※ ２台の仮想マシンは同じサイズで展開

※ データベース サーバー ‐ OS: Windows Server 2012 R2, Database: SQL Server 2014 SP3

※ 作業用仮想マシン - OS: Windows Server 2022
