$(function(){
    var store = new DevExpress.data.CustomStore({
        loadMode: "raw",
        load: function() {
            return $.getJSON("data-kabupaten");
        }
    });

    $("#grid").dxDataGrid({     
        dataSource: store,
        remoteOperations: true,   
        filterRow: {
            visible: true
        },
        headerFilter: {
            visible: true
        },
        groupPanel: {
            visible: true
        },
        scrolling: {
            mode: "virtual"
        },
        height: 600,
        showBorders: true,
        selection: {
            mode: "multiple"
        },
        editing: {
            allowAdding: false,
            allowUpdating: false,
            allowDeleting: false
        },
        grouping: {
            autoExpandAll: false
        },
        export: {
            enabled: true,
            fileName: "Rekap-Yankes-Prov",
            allowExportSelectedData: true
        }
    });
});