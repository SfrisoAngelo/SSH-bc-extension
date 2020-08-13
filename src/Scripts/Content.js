(function ($) {
  $(document).ready(function () {
    var url = Microsoft.Dynamics.NAV.GetImageResource("src/Html/Control.html");
    var varTmp = $("#controlAddIn");
    varTmp.append( `<button>MyFirstButton</button>

    <div class="addin">
        <div class="control">
            <div class="caption">Name:</div>
            <div class="value">
                <input type="text" name="name">
            </div>
        </div>
    
        <div class="control">
            <div class="caption">Surname:</div>
            <div class="value">
                <input type="text" name="name">
            </div>
        </div>
    
        <div class="control">
            <div class="submit">Submit</div>
        </div>
    </div>
    
    <button onclick="helloWorldClick()">Hello, World!</button>
    <script>
        function helloWorldClick() {
            alert("I was clicked!");
        }
    </script>`  )
  });
})(jQuery);