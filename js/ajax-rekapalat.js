var neonLogin = neonLogin || {};
(function($, window, undefined){
    $(document).ready(function(){

        var $table3 = jQuery("#tablerekap");
            var table3 = $table3.DataTable( {
            "aLengthMenu": [[5,10, 25, 50, -1], [5,10, 25, 50, "All"]],
            "dom": '<"panel"<"panel-heading"<"row"<"col-md-6"l><"col-md-6 text-right"f>>>t<"panel-footer"<"row"<"col-md-6"i><"col-md-6 text-right"p>>>>'+'B',
            buttons: ['copy', 'csv', 'excel', 'pdf', 'print'],
            processing: true,
            serverSide: true,
            ajax: 'rekap-alat/getdata',
            columns: [
                { data: 'tahun', name: 'tahun' },
                { data: 'alat', name: 'alat' },
                { data: 'jumlah', name: 'jumlah' }
            ]
        });

        $( '#tablerekap tfoot th' ).each( function () {
                if( $(this).text() != "-" ){
                if( $(this).text() != "Action" ){
                if( $(this).text() != "No" ){
                var title = $('#tablerekap thead th').eq( $(this).index() ).text();
                $(this).html( '<input type="text" class="form-control" placeholder="Cari ' + title + '" />' );
                }}}

                } );
                // Apply the search
        table3.columns().every( function () {
            var that = this;
            $( 'input', this.footer() ).on( 'keyup change', function () {
                if ( that.search() !== this.value ) {
                    that.search( this.value ).draw();
                }
            });
        } );

        var dTable = jQuery('#tablerekap').DataTable(); 
    });

})(jQuery, window);
