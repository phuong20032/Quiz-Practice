        <!-- External JavaScripts -->
        <script src="../admin/assets/js/jquery.min.js"></script>
        <script src="../admin/assets/vendors/bootstrap/js/popper.min.js"></script>
        <script src="../admin/assets/vendors/bootstrap/js/bootstrap.min.js"></script>
        <script src="../admin/assets/vendors/bootstrap-select/bootstrap-select.min.js"></script>
        <script src="../admin/assets/vendors/bootstrap-touchspin/jquery.bootstrap-touchspin.js"></script>
        <script src="../admin/assets/vendors/magnific-popup/magnific-popup.js"></script>
        <script src="../admin/assets/vendors/counter/waypoints-min.js"></script>
        <script src="../admin/assets/vendors/counter/counterup.min.js"></script>
        <script src="../admin/assets/vendors/imagesloaded/imagesloaded.js"></script>
        <script src="../admin/assets/vendors/masonry/masonry.js"></script>
        <script src="../admin/assets/vendors/masonry/filter.js"></script>
        <script src="../admin/assets/vendors/owl-carousel/owl.carousel.js"></script>
        <script src='../admin/assets/vendors/scroll/scrollbar.min.js'></script>
        <script src="../admin/assets/js/functions.js"></script>
        <script src="../admin/assets/vendors/chart/chart.min.js"></script>
        <script src="../admin/assets/js/admin.js"></script>
        <script src='../admin/assets/vendors/switcher/switcher.js'></script>
        <script>
            // Pricing add
            function newMenuItem() {
                var newElem = $('tr.list-item').first().clone();
                newElem.find('input').val('');
                newElem.appendTo('table#item-add');
            }
            if ($("table#item-add").is('*')) {
                $('.add-item').on('click', function (e) {
                    e.preventDefault();
                    newMenuItem();
                });
                $(document).on("click", "#item-add .delete", function (e) {
                    e.preventDefault();
                    $(this).parent().parent().parent().parent().remove();
                });
            }
        </script>
    </body>

    <!-- Mirrored from educhamp.themetrades.com/demo/admin/add-listing.html by HTTrack Website Copier/3.x [XR&CO'2014], Fri, 22 Feb 2019 13:09:05 GMT -->
</html>