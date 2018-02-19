describe file('/etc/firewall/rules.iptables') do
 it { should exist }
 its('content') { should match "Allow SSH" }
end

describe file('/etc/systemd/system/firewall.service') do
 it { should exist }
end

describe systemd_service('firewall') do
  it { should be_installed }
  it { should be_enabled }
  it { should be_running }
end

describe iptables do
  it { should have_rule('-A INPUT -p tcp -m tcp --dport 22 -m conntrack --ctstate NEW -m comment --comment "Allow SSH" -j ACCEPT') }
  it { should have_rule('-A INPUT -j DROP') }
end
