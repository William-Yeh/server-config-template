[NOTE]
We choose Ansible as the configuration management tool.
If you're not familiar with this, read memos on the ABOUT-ANSIBLE directory.


----------------------------------------
* Sample usage (configure the virtual/real machines for the first time):

(a) development environment (with Vagrant):

      $ ansible-playbook -i development -u vagrant -k -vvv site.yml

(b) staging environment:

      $ ansible-playbook -i staging -u [DEPLOYER_NAME] -k -vvv site.yml

(c) production environment:

      $ ansible-playbook -i production -u [DEPLOYER_NAME] -k -vvv site.yml



----------------------------------------
* Useful tools for adm:

(a) convenient-aliases
    Convenient aliases for Ansible cmdline. 

(b) tool-create-app-deployer.yml
    Create server account: add deployment user with sudo rights.

(c) tool-add-authorized-keys.sh
    Install your public key 'id_rsa.pub' in the remote machine's authorized_keys

(d) tool-disable-remote-root-login.yml
    Bootstrap server: disable remote root login.
    USE WITH CAUTION!!!


