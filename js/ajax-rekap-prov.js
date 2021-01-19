$(function(){
    var store = new DevExpress.data.CustomStore({
        loadMode: "raw",
        load: function() {
            return $.getJSON("data-provinsi");
        }
    });

    $("#grid").dxDataGrid({     
        dataSource: store,
        remoteOperations: true,   
        columns: [
            {
                dataField: "provinsi",
                caption: "Provinsi"
            }, 
            { 
                dataField: "RS_Pemerintah",
                caption: "RS Pemerintah"
            },
            { 
                dataField: "RS_TNI_POLRI",
                caption: "RS TNI/POLRI"
            },
            { 
                dataField: "RS_BUMN",
                caption: "RS BUMN"
            },
            { 
                dataField: "RS_Swasta",
                caption: "RS Swasta"
            },
            { 
                dataField: "Puskesmas",
                caption: "Puskesmas"
            },
            { 
                dataField: "Klinik",
                caption: "Klinik"
            },
            { 
                dataField: "Perusahaan",
                caption: "Perusahaan"
            },
            { 
                dataField: "Lain_Lain",
                caption: "Lain - Lain"
            },
            { 
                dataField: "total",
                caption: "Total"
            },
            { 
                dataField: "tahun",
                caption: "Tahun"
            }
        ],
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