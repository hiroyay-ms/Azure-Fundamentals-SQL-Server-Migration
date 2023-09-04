![Microsoft Cloud Workshop](images/ms-cloud-workshop.png)

Azure Fundamentals - Migrate SQL Server to Azure SQL Database
Sep. 2023

<br />

### Contents

- [Exercise 1](#exercise-1)

  - [Azure Database Migration Service の作成](#task-1-azure-database-migration-service-の作成)

  - [セルフホステッド統合ラインタイムの作成と登録](#task-2-セルフホステッド統合ラインタイムの作成と登録)

- [Exercise 2](#exercise-2)

  - [移行先 SQL Database の作成](#task-1-移行先-sql-database-の作成)

  - [サーバー ファイアウォールの設定](#task-2-サーバー-ファイアウォールの設定)

- [Exercise 3](#exercise-3)

  - [Azure Data Studio のインストール](#task-1-azure-data-studio-のインストール)

  - [拡張機能のインストール](#task-2-拡張機能のインストール)

- [Exercise 4](#exercise-4)

  - [SQL Server, SQL Database への接続](#task-1-sql-server-sql-database-への接続)

  - [データベース スキーマの移行](#task-2-データベース-スキーマの移行)

- [Exercise 5](#exercise-5)

  - [データベースの移行](#task-1-データベースの移行)

- [Exercise 6](#exercise-6)

  - [メンテナンス期間の構成](#task-1-メンテナンス期間の構成)

  - [バックアップの構成](#task-2-バックアップの構成)

<br />

## Exercise 1

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

### Task 2: セルフホステッド統合ラインタイムの作成と登録

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

## Exercise 2: 

### Task 1: 移行先 SQL Database の作成

- Azure ポータルのトップ画面で **リソースの作成** をクリック

  <img src="images/add-resources.png" />

- SQL Database の **作成** をクリック

  <img src="images/create-sql-database-01.png" />

- SQL データベースの作成

  - **サーバー** の **新規作成** をクリック
 
  <img src="images/create-sql-database-02.png" />

  - SQL Database サーバーの作成

    - **サーバーの詳細**

      - **サーバー名**: 任意

      - **場所**: リソース グループと同じリージョンを選択
    
    - **認証**

      - **認証方法**: SQL と Azure AD 認証の両方を使用する

      - **Azure AD 管理者の設定をする**: **管理者の設定** をクリック、サインイン中のユーザーを選択

      - **サーバー管理者ログイン**: sqladmin

      - **パスワード**: 任意 (8 文字以上、128 文字以下、英数字、記号の３つ以上を含む)

        <img src="images/create-sql-database-03.png" />

  - **コンピューティングとストレージ** の **データベースの構成** をクリック

    <img src="images/create-sql-database-04.png" />

    - **構成**

      - **サービス レベル**: 汎用目的 (スケーラブルな計算とストレージのオプション)

      - **コンピューティング レベル**: プロビジョニング済み

      - **コストの削減**: いいえ

      - **仮想コア**: 2

      - **データの最大サイズ (GB)**: 5

      - **このデータベース ゾーンに冗長性を持たせますか**: いいえ

        <img src="images/create-sql-database-05.png" />

  - **基本**

    - **プロジェクトの詳細**

      - **サブスクリプション**: ワークショップで使用中のサブスクリプション

      - **リソース グループ**: ワークショップで使用中のリソース グループ
    
    - **データベースの詳細**

      - **データベース名**: AdventureWorksLT2014

      - **サーバー**: 作成した SQL Database サーバー

      - **SQL エラスティック プールを使用しますか**: いいえ

      - **ワークロード環境**: 運用

      - **コンピューティングとストレージ**: 汎用目的 (Gen5, 2 仮想コア, 5GB ストレージ, ゾーン冗長無効)
    
    - **バックアップ ストレージの冗長性**

      - **バックアップ ストレージの冗長性**: ローカル冗長バックアップ ストレージ

      <img src="images/create-sql-database-06.png" />

  - **ネットワーク**

    - **ネットワーク接続**

      - **接続方法**: アクセスなし

    - **接続ポリシー**

      - **接続ポリシー**: 既定
    
    - **暗号化接続**

      - **TLS の最小バージョン**: TLS 1.2

      <img src="images/create-sql-database-07.png" />

  - **セキュリティ**

    - **Microsoft Defender for SQL を有効にする**: 後で

    - **台帳**: 構成されていません

    - **Server Identity**: 無効

    - **Server level key**: 選択済みのサービス マネージド キー

    - **Database level key (preview)**: 構成されていません

      <img src="images/create-sql-database-08.png" />

  - **追加設定**

    - **既定のデータを使用します**: なし

    - **照合順序**: SQL_Latin_1_General_CP1_CI_AS

    - **メンテナンス期間**: システムの既定値 (午後 5 時から午前 8 時)

      <img src="images/create-sql-database-09.png" />

- **確認および作成** をクリック

- **作成** をクリック

  <img src="images/create-sql-database-10.png" />

<br />

### Task 2: サーバー ファイアウォールの設定

- 仮想マシンのグローバル IP アドレスを確認

  ※ [My Global IP](https://www.myglobalip.com/) などのサイトを利用

- 作成した SQL Database の管理ブレードへ移動

- **パブリック ネットワーク アクセス** で **選択したネットワーク** を選択

  <img src="images/server-fire-wall-01.png" />

- **＋ ファイアウォール ルールの追加** をクリック

  <img src="images/server-fire-wall-02.png" />

- ファイアウォール ルール名、確認した仮想マシンのグローバル IP アドレスを入力し **OK** をクリック

  - **ルール名**: AzureDataStudio

  - **開始 IP**: 仮想マシンのグローバル IP アドレス

  - **終了 IP**: 仮想マシンのグローバル IP アドレス

    <img src="images/server-fire-wall-03.png" />

- **保存** をクリック

  <img src="images/server-fire-wall-04.png" />

<br />

## Exercise 3

### Task 1: Azure Data Studio のインストール

- Web ブラウザを起動し

- [Azure Data Studio のダウンロードとインストール](https://learn.microsoft.com/ja-jp/sql/azure-data-studio/download-azure-data-studio?view=sql-server-ver16&tabs=redhat-install%2Credhat-uninstall) サイトへアクセス

- Windows ユーザー インストーラーの **64 ビット** をクリック

  <img src="images/install-azure-data-studio-01.png" />

- ダウンロード完了後、**Openfile** をクリックし、インストーラーを起動

- Setup メッセージが表示されるので **OK** をクリック

- **I accept the agreement** を選択し **Next** をクリック

  <img src="images/install-azure-data-studio-02.png />

- インストール先を確認し **Next** をクリック

  <img src="images/install-azure-data-studio-03.png />

- **Next** をクリック

  <img src="images/install-azure-data-studio-04.png />

- **Create a desktop icon**, **Add to PATH** を選択し **Next** をクリック

  <img src="images/install-azure-data-studio-05.png />

- **Install** をクリック

  <img src="images/install-azure-data-studio-06.png />

- **Launch Azure Data Studio** にチェックが付いていることを確認し **Finish** をクリック

  <img src="images/install-azure-data-studio-08.png />

<br />

### Task 2: 拡張機能のインストール

- Azure Data Studio を起動、画面左の Extensions (<img src="images/extension-icon.png" width="20" />) をクリック

  <img src="images/install-migration-extention-01.png" />

- 検索バーに **azure sql** と入力、表示される候補より **Azure SQL Migration** を選択

  <img src="images/install-migration-extention-02.png" />

- **Install** をクリック

  <img src="images/install-migration-extention-03.png" />

- **検索バー** に **sql database** と入力、表示される候補より **SQL Database Projects** を選択

  <img src="images/install-migration-extention-04.png" />

- **Install** をクリック (同時に SQL Server Schema Compare 拡張機能もインストール)

- ３つの拡張機能がインストールされていることを確認

  <img src="images/install-migration-extention-05.png" />

<br />

## Exercise 4

### Task 1: SQL Server, SQL Database への接続

- 画面左の Connections (<img src="images/connection-icon.png" width="20" />) をクリック

- **New Connection** をクリック

  <img src="images/connect-sql-server-01.png" />

- **Connection Details** に必要なパラメーターを入力し **Connect** をクリック

  - **Connection Type**: Microsoft SQL Server

  - **Input type**: Parameters

  - **Serer**: 移行元 SQL Server 名

  - **Authentication type**: SQL Login

  - **User name**: sqladmin

  - **Password**: パスワード

  - **Remember password**: オン

  - **Database**: Default

  - **Encrypt**: Mandatory (True)

  - **Trust server certificate**: False

  - **Server group**: Default

    <img src="images/connect-sql-server-02.png" />

    ※ SQL Server 名、管理者、パスワードは講師に確認

- Connection erro メッセージが表示されるので **Enable Trust server certificate** をクリック

  <img src="images/connect-sql-server-03.png" />

- SQL Server へ接続

  <img src="images/connect-sql-server-04.png" />

- **New Connection** (<img src="images/new-connection-icon.png" />) をクリック

  <img src="images/connect-sql-server-05.png" />

- **Connection Details** に必要なパラメーターを入力し **Connect** をクリック

  - **Connection Type**: Microsoft SQL Server

  - **Input type**: Parameters

  - **Serer**: 移行先 SQL Database サーバー名

  - **Authentication type**: SQL Login

  - **User name**: sqladmin

  - **Password**: パスワード

  - **Remember password**: オン

  - **Database**: Default

  - **Encrypt**: Mandatory (True)

  - **Trust server certificate**: True

  - **Server group**: Default

    <img src="images/connect-sql-server-06.png" />

- SQL Database へ接続

  <img src="images/connect-sql-server-07.png" />

<br />

### Task 2: データベース スキーマの移行

- 移行元 SQL Server のデータベース (AdvantureWorksLT2014) を右クリックし **Schema Compare** をクリック

  <img src="images/schema-compare-01.png" />

- Target の **...** をクリック

  <img src="images/schema-compare-02.png" />

- **Source**, **Target** の **Type**, **Server**, **Database** を選択し **OK** をクリック

  - **Source**

    - **Type**: Database

    - **Server**: 移行元 SQL Server

    - **Database**: AdventureWorksLT2014
  
  - **Target**

    - **Type**: Database

    - **Server**: 移行先 SQL Database

    - **Database**: AdventureWorksLT2014

    <img src="images/schema-compare-03.png" />

- **Options** をクリック

  <img src="images/schema-compare-04.png" />

- **Include Object Types** タブを選択、**Database Roles**, **Filegroups**, **Users** のチェックを外し **OK** をクリック

  <img src="images/schema-compare-05.png" />

- **Compare** をクリック

  <img src="images/schema-compare-06.png" />

- **Apply** をクリックして、データベース スキーマの移行を実行

  ※ メッセージが表示されるので **Yes** をクリック

  <img src="images/schema-compare-07.png" />

- データベース スキーマが移行されたことを確認

  <img src="images/schema-compare-08.png" />

- **SalesLT.Product** テーブルを右クリックし **Select Top 100** を選択

  <img src="images/schema-compare-09.png" />

- テーブルにデータが登録されていないことを確認

  <img src="images/schema-compare-10.png" />

<br />

## Exercise 5

### Task 1: データベースの移行

- 移行元 SQL Server の AdventureWorksLT2014 データベースを右クリックし **Manage** を選択

  <img src="images/sql-migration-01.png" />

- **Azure SQL Migration** を選択し **Migrate to Azure SQL** をクリック

  <img src="images/sql-migration-02.png" />

- **AdventureWorksLT2014** データベースを選択し **Next** をクリック

  <img src="images/sql-migration-03.png" />

  ※ 移行対象データベースの評価を実行

- **Azure SQL Database** を選択、**View/Select** をクリック

  <img src="images/sql-migration-04.png" />

- SQL Database への移行に問題が検出されないことを確認し **Select** をクリック

  <img src="images/sql-migration-05.png" />

  ※ 移行先 SQL Database のサイジング (本ワークショップでは下記手順は不要です)

  - **Get Azure recommendation**

    - **Collect perfomance data now** を選択、パフォーマンス データを保存する場所を指定し **Start** をクリック

      <img src="images/get-azure-recommendation-01.png" />
    
    - パフォーマンス データの取得を開始
    
      (最小 10 分、Azure Data Studio 起動中は **Stop data collection** をクリックするまで取得を継続)

      <img src="images/get-azure-recommendation-02.png" />
    
    - パフォーマンス データ取得後、**View details** をクリック

      <img src="images/get-azure-recommendation-03.png" />
    
    - パフォーマンス データから推奨サイズを提示

      <img src="images/get-azure-recommendation-04.png" />

      <br />    

- **Next** をクリック

  <img src="images/sql-migration-06.png" />

- **Link account** をクリックし、Azure へ接続

  <img src="images/sql-migration-07.png" />

- **Add an account** をクリック、Web ブラウザが起動、Azure へ接続するための資格情報を入力し認証

  <img src="images/sql-migration-08.png" />

- アカウント名が表示されていることを確認し **Close** をクリック

  <img src="images/sql-migration-09.png" />

- 移行先の SQL Database サーバーの情報を入力し **Connect** をクリック

  - **Subscription**: ワークショップで使用中のサブスクリプション

  - **Location**: リソース グループのリージョン

  - **Resource Group**: ワークショップで使用中のリソース グループ

  - **Azure SQL Database Server**: 移行先の Azure SQL Database サーバー

  - **Target user name**: saladmin

  - **Target password**: パスワード

    <img src="images/sql-migration-10.png" />

- **Target database** に **AdventureWorksLT2014** を選択し **Next** をクリック

  <img src="images/sql-migration-11.png" />

- Azure Database Migration Service が選択され、セルフホステッド統合ランタイムと正常に接続されていることを確認し **Next** をクリック

  <img src="images/sql-migration-12.png" />

- **Run validation** をクリック

  <img src="images/sql-migration-13.png" />

- セルフホステッド統合ランタイム、ソース、ターゲットへの接続を確認、**Done** をクリック

  <img src="images/sql-migration-14.png" />

- **Edit** をクリック

  <img src="images/sql-migration-15.png" />

- すべてのテーブルが選択されていることを確認し **Update** をクリック

  <img src="images/sql-migration-16.png" />

- **Next** をクリック

  <img src="images/sql-migration-17.png" />

- 指定した内容を確認し **Start migration** をクリック

  <img src="images/sql-migration-18.png" />

- **Dashboard** で **Database migrations in progress** をクリック

  <img src="images/sql-migration-19.png" />

- 移行の進行状況を確認

  <img src="images/sql-migration-20.png" />

- **Dashboard** で **Database migrations completed** をクリック、正常に移行が完了したことを確認

  <img src="images/sql-migration-21.png" />

- SQL Database の **SalesLT.Product** テーブルを右クリックし **Select Top 100** を選択

  <img src="images/schema-compare-09.png" />

- データが移行されていることを確認

  <img src="images/sql-migration-22.png" />

<br />

## Exercise 6

### Task 1: メンテナンス期間の構成

- Azure ポータルで SQL Database の管理ブレードを表示、**メンテナンス** を選択

- **メンテナンス期間** から **10:00 PM から 6:00 AM タイムゾーン, 金曜日 から 日曜日** を選択

  ※ タイムゾーンは SQL Database が展開されているリージョンのものが表示

  <img src="images/sql-database-maintenance-01.png" />

- **はい** をクリック

  <img src="images/sql-database-maintenance-02.png" />

<br />

### Task 2: バックアップの構成

- SQL Database の **概要** に表示されるサーバー名をクリック

- **バックアップ** を選択し **保有ポリシー** をクリック、データベースを選択し **ポリシーの構成** をクリック

  <img src="images/sql-database-backup-01.png" />

- バックアップの保有期間を 35 日間に変更し **適用** をクリック

  <img src="images/sql-database-backup-02.png" />

- ポリシー適用を確認するメッセージが表示されるので **はい** をクリック

  <img src="images/sql-database-backup-03.png" />

<br />
