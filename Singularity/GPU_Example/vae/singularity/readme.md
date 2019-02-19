# Building VAE singularity file

```

sudo docker build -t tomaslaz/vae:latest -f vae.dockerfile .; sudo docker push tomaslaz/vae:latest; sudo singularity build vae.simg docker://tomaslaz/vae:latest
```


```
scp vm:/home/tomas/Singularity_containers/tf_vae/vae.simg ~/Desktop/


scp ~/Desktop/vae.simg csd3-gpu:/home/cs-laza1/test_tf_vae/2_CollectiveAllReduceStrategy/


scp ~/Desktop/vae.simg jade:/jmain01/home/JAD029/jph03/txl72-jph03/singularity_test/vae/2_allreduce/
```
