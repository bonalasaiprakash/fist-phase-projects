import subprocess

f = open("../ansible/machineIp", "r")
ansiCtrlIp = f.readline()
f.close()

try:
    # Set scp and ssh data.
    connUser = 'ubuntu'
    connHost = ansiCtrlIp
    connPath = '/tmp/'
    connPrivateKey = '../ssh/xtr'

    # Use scp to send file from local to host.
    tmtAnsible = subprocess.run(['scp', '-i', connPrivateKey, '-o StrictHostKeyChecking=no', '../ansible/tomcat.yaml', '{}@{}:{}'.format(connUser, connHost, connPath)])
    if ((tmtAnsible.returncode) == 0):
        print ("Ansible playbook tomcat.yaml is copied to Ansible controller server")
    else:
        print ("Something went wrong: Ansible playbook tomcat.yaml is NOT copied to Ansible controller server")
    tmpService = subprocess.run(['scp', '-i', connPrivateKey, '-o StrictHostKeyChecking=no', '../ansible/tomcat.service', '{}@{}:{}'.format(connUser, connHost, connPath)])
    if ((tmpService.returncode) == 0):
        print ("Tomcat service file tomcat.service is copied to Ansible controller server")
    else:
        print ("Something went wrong: Tomcat service file tomcat.service is NOT copied to Ansible controller server")

except CalledProcessError:
    print('ERROR: Connection to host failed!')

try:
    runAnsible = subprocess.run(['ssh', '-i', connPrivateKey, '-o StrictHostKeyChecking=no', '{}@{}'.format(connUser, connHost), 'ansible-playbook /tmp/tomcat.yaml'], capture_output=True, text=True)
    if ((runAnsible.returncode) == 0):
        print ("======The Ansible playbook tomcat.yaml ran successfully. Find the below output ======")
        print (runAnsible.stdout)
    else:
        print ("Something went wrong: Ansible playbook tomcat.yaml is NOT run in Ansible controller server")
        print (runAnsible.stdout)
    # tmpService = subprocess.run(['scp', '-i', connPrivateKey, '../ansible/tomcat.service', '{}@{}:{}'.format(connUser, connHost, connPath)])
    # if ((tmpService.returncode) == 0):
    #     print ("Tomcat service file tomcat.service is copied to Ansible controller server")
    # else:
    #     print ("Something went wrong: Tomcat service file tomcat.service is NOT copied to Ansible controller server")

except CalledProcessError:
    print('ERROR: Connection to host failed!')