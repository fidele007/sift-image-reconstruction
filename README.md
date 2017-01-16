# sift-image-reconstruction
## Reconstruct an image from its SIFT local descriptors
Force Fidele KIEN, Herilalaina RAKOTOARISON

Ce projet consiste l'implementation de l'algorithme de reconstruction d'une image à partir de ces descripteurs locaux (selon l'article http://www.irisa.fr/texmex/people/jegou/projects/reconstructing/index.html).

## Executer le programme
* Télécharger les sifts & images de http://lear.inrialpes.fr/people/jegou/data.php
* Dans le main.m, choisir le fichier et le shift correspondant de l'image à reconstruire
* Si besoin, decommenter le code dans stitch.m pour avoir la fonctionnalité de poisson image editing à chaque insertion de patch.

## Références
* Philippe Weinzaepfel, Hervé Jégou, Patrick Pérez : “Reconstructing an image from its local descriptors”
* Herve Jegou, Matthijs Douze et Cordelia Schmid : "Hamming Embedding and Weak geometry consistency for large scale image search" 
* Patrick Pérez, Michel Gangnet et Andrew Blake : “Poisson Image Editing”
* Méthode d'interpolation inpaint_nans créé par John D'Errico  (https://fr.mathworks.com/matlabcentral/fileexchange/4551-inpaint-nans) 

