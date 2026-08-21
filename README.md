# febdora

## Installation

**Verify image**

```
cosign verify --key cosign.pub ghcr.io/febley/febdora:latest
```

**Rebase**

```
sudo bootc switch ghcr.io/febley/febdora:latest
```

## Config

**Enable full HDMI 2.1 Fixed Rate Link (FRL)**

```
rpm-ostree kargs --append-if-missing=amdgpu.dcfeaturemask=0x400
```

**Enable VRR**

```
rpm-ostree kargs --append-if-missing=amdgpu.dcfeaturemask=0x402
```
