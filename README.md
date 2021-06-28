![](https://i.ibb.co/z607zXT/DCNN-ACCELERATORlogos-transparent.png) 


<div align="center">

 [![GitHub stars](https://img.shields.io/github/stars/abdallahabusedo/DCNN)](https://github.com/abdallahabusedo/VLSI/stargazers) [![GitHub issues](https://img.shields.io/github/issues/abdallahabusedo/DCNN)](https://github.com/abdallahabusedo/VLSI/issues)  [![GitHub forks](https://img.shields.io/github/forks/abdallahabusedo/DCNN)](https://github.com/abdallahabusedo/VLSI/network)  [![GitHub](https://img.shields.io/github/license/abdallahabusedo/DCNN)](https://github.com/abdallahabusedo/VLSI/blob/main/LICENSE) <img src="https://img.shields.io/github/languages/count/abdallahabusedo/DCNN" />
</div>

## Description
A detailed low-level chip that applies a CNN classifier over a grayscaled image (MNIST handwritten digits dataset). 
The chip  is a stand-alone chip that reads the image & CNN layers from user, applies the layers (convolution / pooling) consequently, and generates the output label (0 - 9).

## Design


[![](https://i.ibb.co/n8NYzqX/1.png)]()

[![](https://i.ibb.co/GVfLPGB/CPU-CHIP.png)]()

The process is divided into 3 modules:


1.  IO Module

	The image & CNN info will be compressed before sending them to the DCNN accelerator (this part is a software script that applies the compression algorithm - RLE - on the input). Then the compressed files are sent over a parallel port (16bit) to the DCNN accelerator. The received data will be decompressed by the hardware and saved on a local RAM.

	![](https://i.ibb.co/T0Xs5mW/2.png)


2.  CNN Module

	The CNN layers are read and applied one by one in the CNN module. 
	For each layer the module loops over the image using sliding 2D windows and computing the filter result for the middle pixels. 
	The result of each layer is saved in the local RAM to be processed by the next layer.

	![](https://i.ibb.co/6Z5w6qJ/4.png)

3. FC Module

	The last CNN layer result is passed to a fully connected neural network that generates the probability for each label. 
	Finally a softmax layer is used to choose the classifier prediction.

	![](https://i.ibb.co/H74XTYJ/3.png)

## TOOLS

- Vhdl
- Verilog
- Modelsim
- Python


## Contributors
Thanks goes to these wonderful people ✨
<table>
<tr>
<td align="center"><a href="https://github.com/3omar-mostafa"><img src="https://avatars.githubusercontent.com/u/42312059?v=4" width="100px;" alt=""/><br/> <sub><b>Omar Mostafa</b></sub></a></td>

<td align="center"><a href="https://github.com/MENNA123MAHMOUD"><img src="https://avatars.githubusercontent.com/u/42938021?v=4" width="100px;" alt=""/><br/> <sub><b>Menna Mahmoud</b></sub></a></td>

<td align="center"><a href="https://github.com/nadaabdelmaboud"><img src="https://avatars.githubusercontent.com/u/42664649" width="100px;" alt=""/><br/> <sub><b>Nada Abdelmaboud</b></sub></a></td>

<td align="center"><a href="https://github.com/kareem3m"><img src="https://avatars.githubusercontent.com/u/45700579?v=4" width="100px;" alt=""/><br/> <sub><b>Kareem Mohamed</b></sub></a></td>
<td align="center"><a href="https://github.com/devyetii"><img src="https://avatars.githubusercontent.com/u/18527942?v=4" width="100px;" alt=""/><br/> <sub><b>Ebrahim Gomaa</b></sub></a></td>
<td align="center"><a href="https://github.com/EmanOthman21"><img src="https://avatars.githubusercontent.com/u/47359992?v=4" width="100px;" alt=""/><br/> <sub><b>Eman Othman</b></sub></a></td>
</tr>
<tr>
<td align="center"><a href="https://github.com/tarek99samy"><img src="https://avatars.githubusercontent.com/u/43919441?v=4" width="100px;" alt=""/><br/> <sub><b>Tarek Samy</b></sub></a></td>
<td align="center"><a href="https://github.com/abdallahabusedo"><img src="https://avatars.githubusercontent.com/u/42722816?v=4" width="100px;" alt=""/><br/> <sub><b>Abdullah Zaher</b></sub></a></td>
<td align="center"><a href="https://github.com/ayaabohadima"><img src="https://avatars.githubusercontent.com/u/48763545?v=4" width="100px;" alt=""/><br/> <sub><b>Aya Samir</b></sub></a></td>
<td align="center"><a href="https://github.com/hagerali99"><img src="https://avatars.githubusercontent.com/u/56045136?v=4" width="100px;" alt=""/><br/> <sub><b>Hager Ismael</b></sub></a></td>
<td align="center"><a href="https://github.com/Nihal-Mansour"><img src="https://avatars.githubusercontent.com/u/56118744?v=4" width="100px;" alt=""/><br/> <sub><b>Nihal Mansour</b></sub></a></td>
<td align="center"><a href="https://github.com/lenaasayed"><img src="https://avatars.githubusercontent.com/u/42747018?v=4" width="100px;" alt=""/><br/> <sub><b>Asmaa Sayed</b></sub></a></td>
</tr>
</table>

## License

> This software is licensed under MIT License, See [License](https://github.com/abdallahabusedo/VLSI/blob/main/LICENSE)
