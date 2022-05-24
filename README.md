# adaptive splitter
* splits the reads generated during Adaptive sampling based on their decision
1.  accepted reads
2.  rejected reads
3.  no-decision reads


## Install Docker and Nextflow
```shell
sudo apt-get update
sudo apt install -y default-jre
curl -s https://get.nextflow.io | bash
sudo mv nextflow /usr/bin/
sudo apt-get install -y docker-ce docker-ce-cli containerd.io
sudo usermod -a -G docker $USER

```
* Restart your computer



**This project is currently under development**

**Download repo**
```
git clone https://github.com/mult1fractal/adaptive_sampling_decision_splitter.git
cd adaptive_sampling_decision_splitter
```
**Run**
```shell
nextflow run read_split.nf --demultiplex \
--barcode_kit EXP-NBD104 \
--samples /path_to/sample_id_20211124.csv \
--fastq_pass path/to/fastq_pass/ \
--read_until /path/to/adaptive_sampling_FAR97070_53126855.csv \
-profile local,docker -work-dir work/ --cores 20 \
--output /folder/to/store/your/data

```
