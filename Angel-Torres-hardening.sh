#! /bin/bash
#Sistema Operativo
	echo "Identificando Sistema"
ID=$(awk -F= '/^NAME/{print $2}' /etc/os-release)
SO=$(hostnamectl | grep ubuntu)
CAT=$(yum list installed | grep epel)
if [ -z "$SO" ];
then
	echo "Sistema operativo:  "
	echo "$ID"

		if [ -z "$CAT" ];
		then
			echo "Iniciando instalación de EPEL"
			yum -y install epel-release
			echo "EPEL instalado"
		else 
			echo "EPEL ya se encuentra en las aplicaciones"
		fi
		echo "Buscando ClamAV"
		CAT=$(yum list installed | grep clamav)
		if  [ -z "$CAT" ]; 
		then
			echo "Iniciando instalación de ClamAV"
			yum -y install clamav clamav-devel
		else 
			echo "ClamAV ya se encuentra en las aplicaciones "
		fi

		echo "Para actualizar presione Enter"
		read -p "Inserte cualquier caracter para cancelar: " ack
		if [ -z "$ack" ];
		then
			echo " Actualizando... "
			yum update
		else 
			echo "Nada que actualizar"
		fi
fi

SO=$(hostnamectl | grep centos)
if [ -z "$SO" ];
then

	echo "Sistema operativo: "
	echo "$ID"
		echo "Buscando ClamAV"
		CAT=$(dpkg-query -l | grep clamav)
		if  (apt list clamav); 
		then
			echo "ClamAV ya se encuentra en las aplicaciones "
		else 
			echo "Iniciando instalación de ClamAV"
			apt-get install clamav clamav-daemon -y
		fi
		
		#echo "Para actualizar presione enter"
		#read -p "Inserte cualquier caracter para cancelar: " ack
		#if  ("$ack" = ""); 
		#then
			echo " Actualizando... "
			sudo apt-get update
		#else 
			#echo "Nada que actualizar"
		#fi


fi 

exit