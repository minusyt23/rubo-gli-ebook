/// Questa roba è da injectare nella console quando hai aperto il booktab reader
/// Scarica immagini dalla pagina corrente

/// Come input bisogna mettere il numero di pagine da scaricare e quanti millisecondi aspettare tra il caricamento di pagine (valori nel raggio dei secondi sono estremamente consigliati).

((pages, intervalTime) => {
    /// Prepara l'elemento per scaricare
    var dlElement = document.createElement("a");
    dlElement.target = "_blank";
    document.body.appendChild(dlElement);

    var frameNum = 2; // costante

    var i = 0;

    var iDoc = window.frames[frameNum].document;

    interval = setInterval( () => {
        /// Trova canvas
        var canvas = iDoc.getElementsByClassName("slide deck-current")[0].children[0].children[0];

        /// Scarica immagine da canvas
        var dataURI = canvas.toDataURL("image/png");
        dlElement.download = "page" + i + ".png";
        dlElement.href = dataURI;
        dlElement.click();

        /// Vai avanti
        iDoc.getElementById("nextPage").click();

        i++;
        if(i >= pages) clearInterval(interval);
    }, intervalTime);

    /// Clean-up
    document.body.removeChild(dlElement);
    delete dlElement;

})(10, 3000);

// 10 pagine e 3000 millisecondi sono valori predefiniti

