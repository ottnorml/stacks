
describe docker_service('traefik_proxy') do
  it { should exist }
  its('ports') { should include '*:80->80/tcp' }
  its('ports') { should include '*:8080->8080/tcp' }
end

describe docker_service('pihole_pihole') do
  it { should exist }
  its('ports') { should include '*:53->53/tcp' }
  its('ports') { should include '*:53->53/udp' }
  its('ports') { should include '*:67->67/udp' }
  its('ports') { should include '*:8053->80/tcp' }
  its('ports') { should include '*:443->443/tcp' }
end

describe docker_service('portainer_agent') do
  it { should exist }
  its('mode') { should eq 'global' }
  its('ports') { should eq '' }
end

describe docker_service('portainer_portainer') do
  it { should exist }
  its('ports') { should include '*:8000->8000/tcp' }
  its('ports') { should include '*:9000->9000/tcp' }
end

describe docker_service('nextcloud_app') do
  it { should exist }
  its('ports') { should eq '' }
end
