function setOrder(order){
    $("#formAlat #no_order").val(order);
}

function cek_order(no_order){
    $.get('penerimaan/cek/' + no_order, function (data) {
        if (data.pesan==false) {
            $("#formOrder #no_order").closest('.form-control').addClass('is-invalid');
            swal("Peringatan!","nomor order sudah ada","error");
            $("#btn-order").attr("disabled", "disabled");
        }else{
            $("#formOrder #no_order").closest('.form-control').removeClass('is-invalid');
            $("#btn-order").removeAttr("disabled");
        }
    });
}

function nama(cp){
    $("#name").val(cp);
}

var neonLogin = neonLogin || {};
(function($, window, undefined){
    $(document).ready(function(){
        $("#formAlat").hide();
        var $penerima = jQuery( '.penerima' );
        var $pemeriksa = jQuery( '.pemeriksa' );
        var $setatus = jQuery( '.setatus' );
        var $jenis = jQuery( '.jenis' );
        var $provinsi_id = jQuery( '.provinsi_id' );
        var $kabupaten_id = jQuery( '.kabupaten_id' );
        var url_ = "penerimaans";

        var $table3 = jQuery("#tableorder");
            var table3 = $table3.DataTable( {
            "aLengthMenu": [[5,10, 25, 50, -1], [5,10, 25, 50, "All"]],
            buttons: [],
            processing: true,
            serverSide: true,
            ajax: 'penerimaan/getorders',
            columns: [
                { data: 'no', name: 'no' },
                { data: 'no_order', name: 'no_order' },
                { data: 'pemilik', name: 'pemilik' },
                { data: 'setatus', name: 'setatus' },
                { data: 'tgl_terima', name: 'tgl_terima' },
                { data: 'tgl_selesai', name: 'tgl_selesai' },
                { data: 'penerima', name: 'penerima' },
                { data: 'pemeriksa', name: 'pemeriksa' },
                { data: 'action', name: 'action'}
            ]
        });

        $( '#tableorder tfoot th' ).each( function () {
                if( $(this).text() != "-" ){
                if( $(this).text() != "Action" ){
                if( $(this).text() != "No" ){
                var title = $('#tableorder thead th').eq( $(this).index() ).text();
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

        $penerima.select2({
        placeholder: 'Pilih Petugas Penerima',
            ajax: {
                url: 'penerimaan/penerima',
                dataType: 'json',
                delay: 250,
                data: function (term, page) {
                    return {
                      q: term //search term
                    };
                },
                results: function (data) {
                    return {
                        results: $.map(data, function (item) {
                            return {
                                text: item.name,
                                id: item.id
                            }
                        })
                    };
                },
                cache: true
            }
        });

        $pemeriksa.select2({
        placeholder: 'Pilih Petugas Pemeriksa',
            ajax: {
                url: 'penerimaan/pemeriksa',
                dataType: 'json',
                delay: 250,
                data: function (term, page) {
                    return {
                      q: term //search term
                    };
                },
                results: function (data) {
                    return {
                        results: $.map(data, function (item) {
                            return {
                                text: item.name,
                                id: item.id
                            }
                        })
                    };
                },
                cache: true
            }
        });

        $setatus.select2({
        placeholder: 'Status',
            ajax: {
                url: 'penerimaan/setatus',
                dataType: 'json',
                delay: 250,
                data: function (term, page) {
                    return {
                      q: term //search term
                    };
                },
                results: function (data) {
                    return {
                        results: $.map(data, function (item) {
                            return {
                                text: item.setatus,
                                id: item.id
                            }
                        })
                    };
                },
                cache: true
            }
        });

        $jenis.select2({
        placeholder: 'Jenis Fasyankes',
            ajax: {
                url: 'penerimaan/jenis',
                dataType: 'json',
                delay: 250,
                data: function (term, page) {
                    return {
                      q: term //search term
                    };
                },
                results: function (data) {
                    return {
                        results: $.map(data, function (item) {
                            return {
                                text: item.jenis,
                                id: item.id
                            }
                        })
                    };
                },
                cache: true
            }
        });

        $provinsi_id.select2({
        placeholder: 'Pilih Provinsi',
            ajax: {
                url: 'penerimaan/provinsi',
                dataType: 'json',
                delay: 250,
                data: function (term, page) {
                    return {
                      q: term //search term
                    };
                },
                results: function (data) {
                    return {
                        results: $.map(data, function (item) {
                            return {
                                text: item.name,
                                id: item.provinsi_id
                            }
                        })
                    };
                },
                cache: true
            }
        });

        $kabupaten_id.select2({
        placeholder: 'Pilih Kabupaten',
            ajax: {
                url: 'penerimaan/kabupaten',
                dataType: 'json',
                delay: 250,
                data: function (term, page) {
                    return {
                      q: term, //search term
                      prov:$("#provinsi_id").val()
                    };
                },
                results: function (data) {
                    return {
                        results: $.map(data, function (item) {
                            return {
                                text: item.name,
                                id: item.kabupaten_id
                            }
                        })
                    };
                },
                cache: true
            }
        });

        $(document).on("click", ".data-order", function () {
            var id = $(this).val();
            $.get('penerimaans/' + id, function (data) {
                $(".modal-title").text("Edit Data Nomor Order "+data.no_order);
                $("#btn-order").html('Update Order <i class="icon md-edit"></i>');
                $("#no_order").val(data.no_order);
                $("#tgl_terima").val(data.tgl_terima);
                $("#tgl_selesai").val(data.tgl_selesai);
                $("#pemilik").val(data.pemilik);
                $setatus.select2("data", {id: data.setatus_id, text: data.setatus});

                $jenis.select2("data", {id: data.jenis_id, text: data.jenis});
                $provinsi_id.select2("data", {id: data.provinsi_id, text: data.provinsi});
                $kabupaten_id.select2("data", {id: data.kabupaten_id, text: data.kabupaten});

                $("#alamat").val(data.alamat);
                $("#telepon").val(data.telepon);
                $("#cp").val(data.cp);
                $("#hp").val(data.hp);
                $("#catatan").val(data.catatan);
                $("#name").val(data.name);
                $penerima.select2("data", {id: data.penerima_id, text: data.penerima});
                $pemeriksa.select2("data", {id: data.pemeriksa_id, text: data.pemeriksa});
                
                if (data.kup==1) {
                    $("#kup").attr( 'checked', 'checked' );
                }else{
                    $("#kup").attr( 'checked', false )
                }

                if (data.kkl==1) {
                    $("#kkl").attr( 'checked', 'checked' );
                }else{
                    $("#kkl").attr( 'checked', false )
                }

                if (data.kpp==1) {
                    $("#kpp").attr( 'checked', 'checked' );
                }else{
                    $("#kpp").attr( 'checked', false )
                }

                if (data.bpj==1) {
                    $("#bpj").attr( 'checked', 'checked' );
                }else{
                    $("#bpj").attr( 'checked', false )
                }

                if (data.kpr==1) {
                    $("#kpr").attr( 'checked', 'checked' );
                }else{
                    $("#kpr").attr( 'checked', false )
                }

                if (data.kmk==1) {
                    $("#kmk").attr( 'checked', 'checked' );
                }else{
                    $("#kmk").attr( 'checked', false )
                }

                if (data.akl==1) {
                    $("#akl").attr( 'checked', 'checked' );
                }else{
                    $("#akl").attr( 'checked', false )
                }
                $("#formOrder").show();
                $('#btn-order').val("update_order");
                $('#myModal').modal('show');
            }) 
        });

        $(document).on("click", ".data-alat", function () {
            var no_order = $(this).val();

                            $.ajaxSetup({
                              headers: {'X-CSRF-TOKEN': $('meta[name="_token"]').attr('content')}
                            });
                            
                            $("#modal-id2").modal("show"); 

                            var detail = new DevExpress.data.CustomStore({
                              key: "id",
                              load: function(loadOptions) {
                                var d = new $.Deferred();
                                var params = {};
                                params.skip = loadOptions.skip; 
                                params.take = loadOptions.take; 
                                $.getJSON('details/getalat/'+no_order, params).done(function (data) {
                                      d.resolve(data.items, { totalCount: data.count }); 
                                });
                                return d.promise();
                              },
                              insert: function (values) {
                                  return $.ajax({
                                      url: "details",
                                      method: "POST",
                                      data: {
                                        no_order:no_order,
                                        alat_id:values.alat_id,
                                        merek:values.merek,
                                        model:values.model,
                                        seri:values.seri,
                                        jumlah:values.jumlah,
                                        fungsi:values.fungsi,
                                        kelengkapan:values.kelengkapan,
                                        keterangan:values.keterangan
                                      }
                                  });
                              },
                              update: function (key, values) {
                                return $.ajax({
                                  url: "details/"+key,
                                  method: "PUT",
                                  data: values
                                })
                              }
                            });
                            $("#detail").dxDataGrid({
                                      dataSource: detail,
                                      paging: {
                                          pageSize: 15
                                      },
                                      remoteOperations: true,   
                                      scrolling: {
                                          mode: "virtual",
                                          rowRenderingMode: "virtual"
                                      },
                                      height: 500,
                                      showBorders: true,
                                      selection: {
                                        mode: "single"
                                      },
                                      editing: {
                                          mode: 'row',
                                          allowAdding: true,
                                          allowUpdating: true,
                                          allowDeleting: true,
                                          texts: {
                                              addRow: "Tambah data",
                                              cancelAllChanges: "Discard changes",
                                              cancelRowChanges: "Batal",
                                              confirmDeleteMessage: "Hapus Data ini",
                                              confirmDeleteTitle: "",
                                              deleteRow: "Hapus",
                                              editRow: "Edit",
                                              saveAllChanges: "Simpan Perubahan",
                                              saveRowChanges: "Simpan",
                                              undeleteRow: "Batalkan",
                                              validationCancelChanges: "Cancel changes"
                                          },
                                          useIcons: true
                                      },
                                      onEditingStart: function(em) {
                                          em.component.columnOption("rownum", "allowEditing", false);
                                      },
                                      columns: [
                                          {
                                              dataField: "alat_id",
                                              caption:"Alat",
                                              width:"200",
                                              lookup: {
                                                    dataSource: {
                                                        paginate: true,
                                                        store: new DevExpress.data.CustomStore({
                                                            key: "id",
                                                            loadMode: "raw",
                                                            load: function() {
                                                                return $.getJSON("penerimaan/alat");
                                                            }
                                                        })
                                                    },
                                                    valueExpr: "id",
                                                    displayExpr: "nama"
                                            }
                                          },
                                          {
                                              dataField: "merek",
                                              caption:"Merk",
                                              dataType:"string"
                                          },
                                          {
                                              dataField: "model",
                                              caption:"Model/Type",
                                              dataType:"string"
                                          },
                                          {
                                              dataField: "seri",
                                              caption:"No Seri",
                                              dataType:"string"
                                          },
                                          {
                                              dataField: "jumlah",
                                              caption:"Jumlah",
                                              dataType:"number"
                                          },
                                          {
                                              dataField: "fungsi",
                                              caption:"Fungsi",
                                              lookup: {
                                                    dataSource: {
                                                        paginate: true,
                                                        store: new DevExpress.data.CustomStore({
                                                            key: "id",
                                                            loadMode: "raw",
                                                            load: function() {
                                                                return $.getJSON("penerimaan/fungsi");
                                                            }
                                                        })
                                                    },
                                                    valueExpr: "id",
                                                    displayExpr: "fungsi"
                                            }
                                          },
                                          {
                                              dataField: "kelengkapan",
                                              caption:"Kelengkapan",
                                              dataType:"string"
                                          },
                                          {
                                              dataField: "keterangan",
                                              caption:"Keterangan",
                                              dataType:"string"
                                          },
                                          {
                                            type: "buttons",
                                            width: 110,
                                            buttons: [
                                              "edit", 
                                              {
                                                hint:"Hapus",
                                                icon:"trash",
                                                onClick:function(ed){
                                                          $.ajaxSetup({
                                                              headers: {'X-CSRF-TOKEN': $('meta[name="_token"]').attr('content')}
                                                          });

                                                          $.ajax({
                                                              type: "DELETE",
                                                              url: "details/"+ed.row.data.id,
                                                              success: function (data) {
                                                                ed.component.refresh(true);
                                                              },
                                                              error: function (data) {
                                                                  console.log('Error:', data);
                                                              }
                                                          });
                                                }
                                              },
                                              {
                                                hint: "Copy",
                                                icon: "unselectall",
                                                onClick: function(ev) {
                                                  $.ajaxSetup({
                                                      headers: {
                                                          'X-CSRF-TOKEN': $('meta[name="_token"]').attr('content')
                                                      }
                                                  });

                                                  var formData = {
                                                        no_order:ev.row.data.no_order,
                                                        alat_id:ev.row.data.alat_id,
                                                        merek:ev.row.data.merek,
                                                        model:ev.row.data.model,
                                                        seri:ev.row.data.seri,
                                                        jumlah:ev.row.data.jumlah,
                                                        fungsi:ev.row.data.fungsi,
                                                        kelengkapan:ev.row.data.kelengkapan,
                                                        keterangan:ev.row.data.keterangan
                                                  };

                                                  
                                                  // console.log(formData);
                                                  $.ajax({
                                                      type: "POST",
                                                      url: "copy-details",
                                                      data: formData,
                                                      dataType: 'json',
                                                      success: function (data) {
                                                          ev.component.refresh(true);
                                                          // ev.event.preventDefault();
                                                      },
                                                      error: function (data) {
                                                          console.log('Error:', data);
                                                      }
                                                  });
                                                }
                                              }
                                            ]
                                          }
                                      ]
                            });
        });



        neonLogin.$container = $("#formOrder");
        var validator = neonLogin.$container.validate({
            ignore: [],
            rules: {
                no_order: {
                    required: true, 
                },
                tgl_terima: {
                    required: true,  
                },
                tgl_selesai: {
                    required: true,  
                },
                pemilik: {
                    required: true,  
                },
                alamat: {
                    required: true,  
                },
                name: {
                    required: true,  
                },
                penerima: {
                    required: true,  
                },
                pemeriksa: {
                    required: true,  
                }
                
            },

            highlight: function(element){
                $(element).closest('.form-control').addClass('is-invalid');
            },
            unhighlight: function(element)
            {
                $(element).closest('.form-control').removeClass('is-invalid');
            },
            // errorElement: "span",
            // errorClass: "help-block",
            errorPlacement: function(error, element) {  
                
            },
            submitHandler: function(ev)
            {
                $("#kup").prop("checked") ? $("#kup").val("1") : $("#kup").val("0");
                $("#kkl").prop("checked") ? $("#kkl").val("1") : $("#kkl").val("0");
                $("#kpp").prop("checked") ? $("#kpp").val("1") : $("#kpp").val("0");
                $("#bpj").prop("checked") ? $("#bpj").val("1") : $("#bpj").val("0");
                $("#kpr").prop("checked") ? $("#kpr").val("1") : $("#kpr").val("0");
                $("#kmk").prop("checked") ? $("#kmk").val("1") : $("#kmk").val("0");
                $("#akl").prop("checked") ? $("#akl").val("1") : $("#akl").val("0");
                $.ajaxSetup({
                    headers: {
                        'X-CSRF-TOKEN': $('meta[name="_token"]').attr('content')
                    }
                })
                var formData = $('#formOrder').serialize();
                var state = $('#btn-order').val();
                var type = "POST"; //for creating new resource
                var no_order = $('#no_order').val();;
                var my_url = url_;
                $("#btn-order").attr("disabled", "disabled");

                if (state == "update_order"){
                    var pesan ="Data telah diupdate";
                    type = "PUT"; //for updating existing resource
                    my_url += '/' + no_order;
                    swal({
                        title: "Konfirmasi",
                        text: "Simpan data order?",
                        icon: "warning",
                        buttons: ["Batal", "Simpan"],
                        dangerMode: true,
                    })
                    .then((willDelete) => {
                        if (willDelete) {
                            $.ajax({
                                type: type,
                                url: my_url,
                                data: formData,
                                dataType: 'json',
                                success: function (data) {
                                    $('#myModal').modal('hide');
                                    jQuery("#tableorder").DataTable().ajax.reload(null,false);
                                    swal("Berhasil!",pesan,"success");
                                    $("#btn-order").removeAttr("disabled");
                                },
                                error: function (data) {
                                    console.log('Error:', data);
                                }
                            });
                        } else {
                          // swal("Your imaginary file is safe!");
                        }
                    }); 
                }else{
                    var pesan ="Data telah disimpan";
                    swal({
                        title: "Konfirmasi",
                        text: "Simpan data order?",
                        icon: "warning",
                        buttons: ["Batal", "Simpan"],
                        dangerMode: true,
                    })
                    .then((willDelete) => {
                        if (willDelete) {
                            $.ajax({
                                type: type,
                                url: my_url,
                                data: formData,
                                dataType: 'json',
                                success: function (data) {
                                    $("#btn-order").removeAttr("disabled");
                                    $("#formOrder").hide();
                                    $('#myModal').modal('hide');
                                    jQuery("#tableorder").DataTable().ajax.reload(null,false);
                                    swal("Berhasil!",pesan,"success");
                                },
                                error: function (data) {
                                    console.log('Error:', data);
                                }
                            });
                        } else {
                          // swal("Your imaginary file is safe!");
                        }
                    }); 
                }
               
            }
        });

        $(document).on("click", ".delete-task", function () {
            swal({
                title: "Konfirmasi",
                text: "Hapus Data Order?",
                icon: "warning",
                buttons: ["Batal", "Hapus"],
                dangerMode: true,
            })
            .then((willDelete) => {
                if (willDelete) {
                    var id = $(this).val();
                    $.ajaxSetup({
                        headers: {'X-CSRF-TOKEN': $('meta[name="_token"]').attr('content')}
                    });

                    $.ajax({
                        type: "DELETE",
                        url: url_ + '/' + id,
                        success: function (data) {
                            jQuery("#tableorder").DataTable().ajax.reload(null,false);
                            swal("Berhasil!","Data telah dihapus","success");
                        },
                        error: function (data) {
                            console.log('Error:', data);
                        }
                    });
                } else {
                  // swal("Your imaginary file is safe!");
                }
            }); 
            
        });

        

        var $alat = jQuery( '.alat' );
        var $fungsi = jQuery( '.fungsi' );
        $alat.select2({
        placeholder: 'Pilih Alat',
            ajax: {
                url: 'penerimaan/alat',
                dataType: 'json',
                delay: 250,
                data: function (term, page) {
                    return {
                      q: term //search term
                    };
                },
                results: function (data) {
                    return {
                        results: $.map(data, function (item) {
                            return {
                                text: item.nama,
                                id: item.id
                            }
                        })
                    };
                },
                cache: true
            }
        });

        $fungsi.select2({
        placeholder: 'Fungsi',
            ajax: {
                url: 'penerimaan/fungsi',
                dataType: 'json',
                delay: 250,
                data: function (term, page) {
                    return {
                      q: term //search term
                    };
                },
                results: function (data) {
                    return {
                        results: $.map(data, function (item) {
                            return {
                                text: item.fungsi,
                                id: item.id
                            }
                        })
                    };
                },
                cache: true
            }
        });

        $(document).on('click','.finished',function(){
            var validator = $("#formOrder").validate();
            validator.resetForm();
            $('.nav-tabs a[href="#exampleTabsOne"]').tab('show');
            $("#formOrder").closest('.form-control').removeClass('is-invalid');
            $("#btn-order").removeAttr("disabled");
            $(".modal-title").text("Input Penerimaan Alat");
            $('#btn-alat').html('<i class="icon md-plus"></i> Tambah Alat');
            $('#btn-alat').val("add");
            $("#myModal").modal("hide");
            $('#formOrder').trigger("reset");
            $('#formAlat').trigger("reset");
            // $('.cb input').prop('checked', false);
            $("#formAlat").hide();
            $("#formOrder").show();
            $penerima.select2("val", "");
            $pemeriksa.select2("val", "");
            $setatus.select2("val", "");
            $("#customers_select").select2("val", "");
            jQuery("#tablealat").DataTable().destroy();
            jQuery("#tableorder").DataTable().ajax.reload(null,false);
        });

        //display modal form for task editing
        $(document).on("click", ".open-modal", function () {
            var id = $(this).val();

            $.get(url_ + '/' + id, function (data) {
                //success data
                $('#id').val(data.id);
                $('#name').val(data.name);
                $('#address').val(data.address);
                $('#btn-save').val("update");
                $('#myModal').modal('show');
            }) 
        });

        //display modal form for creating new task
        $('#btn-add').click(function(){
            $('#btn-order').html('Selesai <i class="icon md-long-arrow-right"></i>');
            $('#btn-order').val("add_order");
            $('#btn-save').val("add");
            $('#frmcustomer').trigger("reset");
            $('#myModal').modal('show');
        });

  
    });
})(jQuery, window);
