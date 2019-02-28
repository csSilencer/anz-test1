# generate a certificate using JKS format keystore
keytool -genkey -alias selfrest -keyalg RSA -keypass password123 -storetype JKS -keystore selfsigned.jks -storepass password123 -validity 360 -keysize 2048

# To check the content of the keystore, we can use keytool again:
keytool -list -v -keystore selfsigned.jks

#Export Self signed certificate into .cer file
keytool -exportcert -alias selfrest -keystore selfsigned.jks -file selfsigned.cer
