<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  <xsl:output indent="yes" method="html" />
  <xsl:include href="layout.xsl" />

  <xsl:template match="/project" mode="contents">

    <div class="hero-unit">
      <h1>
	<xsl:value-of select="$title" disable-output-escaping="yes"/>
	<xsl:if test="$title = ''">phpDocumentor</xsl:if>
      </h1>
      <h2>Author:  Chen Han</h2>
    </div>
    <div class="well">
      <h3>総覧</h3>
      <hr />

      <p>bremenはミライロが考案し、Penseurが受託した製作案件です。</p>
      
      <p>藤田 あいがデザインを担当した、チェン ハンが設計、実装、インフラ整備、ドキュメントなどを担当した。</p>

      <p>開発は2014年7月初からスタートし、初回リリースは2014年9月末までとなった。</p>
      <br />
      <h3>開発背景など</h3>
      <hr />

      <p><a href="http://goo.gl/tGGURz">業務記録</a>、<a href="http://goo.gl/JQNoJK">現況一覧</a> を参照してください。</p>
      <br />

      <h3>プロジェクト構成</h3>
      <hr />

      <h4>サーバー側及びサーバー実装構成</h4>
      <br />
      <p>サーバー側は<a href="https://github.com/gpgkd906/framework">myframework</a>を利用して構築しています。</p>
      <br />
      
      <h4>アプリ側</h4>
      <br />
      <p><a href="../bremen/">アプリ側ドキュメント</a> を参照してください。</p>
      <br />

      <h4>サーバーアプリ実装構成</h4>
      <br />
      <p>Bremen サーバーはMVCに基づいて構築しています、大きくController,Model(Store)に分けて実装を行った。</p>
      <p>Viewに関しては、9月末の時点では、主にスマホアプリのバックエンドとしてサービスを提供するので実装は不要</p>
      <p>サービスとして、スマホアプリが必要とするrest APIを提供しています</p>
      <p>rest APIは<a href="packages/framework.controller.html">コントローラ</a>で定義され、コントローラ内部でデータの取得、更新などは<a href="packages/framework.model.html">各モデル</a>で定義されている</p>
      <br />
      
      <h4>ライセンスに関して</h4>
      <br />
      <p>myframework自体のライセンスが<a href="http://opensource.org/licenses/MIT">MITライセンス</a>となります。</p>
      <br />

      <h4>アプリの拡張や修正について</h4>
      <br />
      <p>サービスとしてのwebアプリケーションを二次開発する場合は基本的に以下の二か所で作業する</p>
      <p><a href="packages/framework.controller.html"><i class="icon-folder-open"></i>　framework.controller</a>　API定義など</p>
      <p><a href="packages/framework.model.html"><i class="icon-folder-open"></i>　framework.model</a>　データ保存・更新・削除実装</p>
      
      <p>フレームワーク自体の二次開発は以下で行います</p>
      <p><a href="packages/framework.core.html"><i class="icon-folder-open"></i>　framework.core</a>　高級者向け</p>
      <br />
      <h4>ドキュメントについて</h4>
      <br />

      <p>本ドキュメントはphpDocumentor 2を利用して作成され、ソースコードを含まない。</p>
      
      <a href="http://www.phpdoc.org/docs/latest/index.html">phpDocumentor2のドキュメント</a>
      
    </div>
    <div class="row">
      <div class="span7">
	<xsl:if test="count(/project/namespace[@name != 'default' and @name != 'global' and @name != '']) > 0">
	  <div class="well">
	    <ul class="nav nav-list">
	      <li class="nav-header">Namespaces</li>
	      <xsl:apply-templates select="/project/namespace" mode="menu">
		<xsl:sort select="@full_name" />
	      </xsl:apply-templates>
	    </ul>
	  </div>
	</xsl:if>

	<xsl:if test="count(/project/package[@name != '' and @name != 'default']) > 0 or count(/project/namespace[@name != 'default' and @name != 'global' and @name != '']) = 0">
	  <div class="well">
	    <ul class="nav nav-list">
	      <li class="nav-header">Packages</li>
	      <xsl:apply-templates select="/project/package" mode="menu">
		<xsl:sort select="@name"/>
	      </xsl:apply-templates>
	    </ul>
	  </div>
	</xsl:if>

	<xsl:if test="count(/project/file/class[docblock/tag[@name='api']]) + count(/project/file/class[docblock/tag[@name='api']]/method[@visibility='public' and substring(name,1,2)!='__']) + count(/project/file/class/method[@visibility='public' and docblock/tag[@name='api']]) > 0">
	  <div class="well">
	    <ul class="nav nav-list">
	      <li class="nav-header">Api</li>

	      <xsl:variable name="classes" select="/project/file/class[docblock/tag[@name='api']]"/>
	      <xsl:if test="count($classes) > 0">
		<li class="nav-header"><i class="icon-custom icon-class"></i> Public API Classes</li>
		<xsl:for-each select="$classes">
		  <li><a href="classes/{name}.html" title="{docblock/description}"><xsl:value-of select="name" /></a></li>
		</xsl:for-each>
	      </xsl:if>

	      <xsl:variable name="methods" select="/project/file/class[docblock/tag[@name='api']]/method[@visibility='public' and substring(name,1,2)!='__']|/project/file/class/method[@visibility='public' and docblock/tag[@name='api']]"/>
	      <xsl:if test="count($methods) > 0">
		<li class="nav-header"><i class="icon-custom icon-method"></i> Public API Methods</li>
		<xsl:for-each select="$methods">
		  <li><a href="classes/{../name}.html#{name}" title="{docblock/description}"><xsl:value-of select="../name" />.<xsl:value-of select="name" /></a></li>
		</xsl:for-each>
	      </xsl:if>
	    </ul>
	  </div>
	</xsl:if>

      </div>
      <div class="span5">
	<div class="well">
	  <ul class="nav nav-list">
	    <li class="nav-header">Charts</li>
	    <li>
	      <a href="{$root}graph_class.html">
		<i class="icon-list-alt"></i> Class inheritance diagram
	      </a>
	    </li>
	  </ul>
	</div>
	<div class="well">
	  <ul class="nav nav-list">
	    <li class="nav-header">Reports</li>
	    <xsl:apply-templates select="/" mode="report-overview" />
	  </ul>
	</div>
      </div>
    </div>
  </xsl:template>

</xsl:stylesheet>