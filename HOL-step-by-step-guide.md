![Microsoft Cloud Workshop](images/ms-cloud-workshop.png)

Azure Fundamentals - Migrate SQL Server to Azure SQL Database
Sep. 2023

<br />

### Contents


<br />

## Exercise 1: 

### Task 1: Azure Database Migration Service の作成

- [Azure ポータル](https://portal.azure.com) へアクセス

- トップ画面の検索バーに **azure database migration service** と入力し、表示される候補より **Azure Database Migration Service** を選択

  <img src="images/create-migration-project-01.png" />

- **＋ 作成** をクリック

  <img src="images/create-migration-project-02.png" />

- 移行シナリオと Database Migration Service

  - **ソース サーバーの種類**: SQL Server

  - **ターゲット サーバーの種類**: Azure SQL Database

  - **Database Migration Service**: Data Migration Service

    <img src="images/create-migration-project-03.png" />

- **選択** をクリック

- Create Data Migration Service

  - **Basics**

    - **Subscription**: ワークショップで使用中のサブスクリプション

    - **Resource group**: ワークショップで使用中のリソース グループ

    - **Instance details**

      - **Location**: リソース グループと同じリージョンを選択

      - **Migration service name**: 任意

        <img src="images/create-migration-project-04.png" />

- **Review + create** をクリック

- **Create** をクリック

  <img src="images/create-migration-project-05.png" />

<br />

### Task 2: 統合ラインタイムのインストール＆登録

- 作成した Database Migration Service の管理ブレードを表示

- **統合ランタイム** を選択し、**Congigure integration runtime** をクリック

  <img src="images/create-migration-project-06.png" />

- **Download and install the integration runtime** をクリック

  <img src="images/create-migration-project-07.png" />

- Web ブラウザが起動し Microsoft Integration Runtime のダウンロード サイトが表示

- **Download** をクリック

  <img src="images/create-migration-project-08.png" />

  <br />

- 最新バージョン (IntegrationRuntime_5.33.8615.3.msi) を選択し、**Download** をクリック

- ダウンロード完了後、**Open file** をクリックし、インストーラーを起動

- **Next** をクリック

  <img src="images/install-self-hosted-runtime-01.png" />

- **I accept the terms in the License Agreement** にチェックを付け、**Next** をクリック

  <img src="images/install-self-hosted-runtime-02.png" />

- インストール先を確認し **Next** をクリック

  <img src="images/install-self-hosted-runtime-03.png" />

- **Install** をクリックし、インストールを開始

  <img src="images/install-self-hosted-runtime-04.png" />

- **Finish** をクリック

  <img src="images/install-self-hosted-runtime-05.png" />

- Microsoft Intagration Runtime Configuration Manager が起動

- Azure ポータルから Configure integration runtime に表示されているキーをコピーし貼り付け **Register** をクリック

  <img src="images/install-self-hosted-runtime-06.png" />

- **Finish** をクリック

  <img src="images/install-self-hosted-runtime-07.png" />

- 再度 **Regiter** をクリックし、登録を実行

- 正常に登録が完了したことを確認し **Close** をクリック

  <img src="images/install-self-hosted-runtime-08.png" />

- Azure ポータルでも統合ラインタイムのノードが登録されていることを確認

  <img src="images/install-self-hosted-runtime-09.png" />

<br />

## Exerciese 2: 

Task 1: SQL Database の作成


  <img src="images/create-sql-database-01.png" />

  <img src="images/create-sql-database-02.png" />

  <img src="images/create-sql-database-03.png" />

  <img src="images/create-sql-database-04.png" />

  <img src="images/create-sql-database-05.png" />

  <img src="images/create-sql-database-06.png" />

  <img src="images/create-sql-database-07.png" />

  <img src="images/create-sql-database-08.png" />

  <img src="images/create-sql-database-09.png" />

  <img src="images/create-sql-database-10.png" />

<br />
