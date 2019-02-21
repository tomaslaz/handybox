# Building VAE singularity file

```
scp /Users/tlazauskas/git/Tomaslaz/handybox/Singularity/GPU_Example/vae/singularity/vae.py vm://home/tomas/Singularity_containers/tf_vae/
```

```
sudo docker build -t tomaslaz/vae:mirror -f vae.dockerfile .; sudo docker push tomaslaz/vae:mirror
```

```
sudo singularity build vae.simg docker://tomaslaz/vae:mirror
```


```
scp vm:/home/tomas/Singularity_containers/tf_vae/vae.simg ~/Desktop/; scp ~/Desktop/vae.simg jade:/jmain01/home/JAD029/jph03/txl72-jph03/singularity_test/vae/1_mirrored/
```

```
scp ~/Desktop/vae.simg csd3-gpu:/home/cs-laza1/test_tf_vae/1_MirroredStrategy/


scp ~/Desktop/vae.simg jade:/jmain01/home/JAD029/jph03/txl72-jph03/singularity_test/vae/2_allreduce/
```
