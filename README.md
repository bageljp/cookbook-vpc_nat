What's ?
===============
chef で使用する VPCのNATインスタンスの設定をする cookbook です。  
iptablesでnatテーブルを設定しているだけなのでVPCに限らず使えます。

Usage
-----
cookbook なので berkshelf で取ってきて使いましょう。

* Berksfile
```ruby
source "https://supermarket.chef.io"

cookbook "vpc_nat", git: "https://github.com/bageljp/cookbook-vpc_nat.git"
```

```
berks vendor
```

#### Role and Environment attributes

* sample_role.rb
```ruby
override_attributes(
  "vpc_nat" => {
    "source" => "172.31.0.0/16"
  }
)
```

AWS管理コンソールからNATインスタンスの「Change Source/Dest. Check」を Disable にしてください。  
またVPCの Route Table の設定で Default Gateway をNATインスタンスにするのを忘れずに。

Recipes
----------

#### vpc_nat::default
iptablesでNATをするための設定。  
iptablesが有効になるのでもし昔のアクセス制御の設定が入っていてiptablesを無効にしていた場合などは注意。  

Attributes
----------

主要なやつのみ。

#### vpc_nat::default
<table>
  <tr>
    <th>Key</th>
    <th>Type</th>
    <th>Description</th>
  </tr>
  <tr>
    <td><tt>['vpc_nat']['interface']</tt></td>
    <td>string</td>
    <td>iptablesで設定する送信元（SNATする）側のインタフェース名。VPCなら通常eth0しかないので気にする必要なし。</td>
  </tr>
  <tr>
    <td><tt>['vpc_nat']['source']</tt></td>
    <td>string</td>
    <td>iptablesで設定する送信元（SNATする）側のネットワークアドレス。</td>
  </tr>
</table>

