@extends('admin-template')
@section('content')
                <div class="row">
                    <div class="col-sm-12">
                        <div class="page-title-box">
                            <div class="btn-group pull-right">
                                <ol class="breadcrumb hide-phone p-0 m-0">
                                    <li class="breadcrumb-item"><a href="{{ route('admin.dashboard') }}">LPFK BJB</a></li>
                                    <li class="breadcrumb-item active">Penerimaan Alat</li>
                                </ol>
                            </div>
                            <h4 class="page-title">&nbsp;</h4>
                        </div>
                    </div>
                </div>

                <div class="row">
                  <div class="col-md-12">
                    <div class="card m-b-30">
                            <div class="card-header">
                                <button type="button" class="btn btn-gradient waves-light waves-effect w-md" id="btn-add">Tambah Data</button>
                            </div>
                            <div class="card-body">
                                <table class="table table-striped table-bordered" cellspacing="0" id="tableorder" width="100%">
                                <thead>
                                  <tr>
                                    <th>No</th>
                                    <th>No Order</th>
                                    <th>Pemilik</th>
                                    <th>Status</th>
                                    <th>Tgl Terima</th>
                                    <th>Tgl Selesai</th>
                                    <th>Penerima</th>
                                    <th>Pemeriksa</th>
                                    <th>Action</th>
                                  </tr>
                                </thead>
                                <tfoot>
                                  <tr>
                                    <th>No</th>
                                    <th>No Order</th>
                                    <th>Pemilik</th>
                                    <th>Status</th>
                                    <th>Tgl Terima</th>
                                    <th>Tgl Selesai</th>
                                    <th>Penerima</th>
                                    <th>Pemeriksa</th>
                                    <th>Action</th>
                                  </tr>
                                </tfoot>
                              </table>


                              <!-- Modal -->
                              <div class="modal fade modal-rotate-from-bottom" id="myModal" aria-hidden="true" aria-labelledby="exampleModalTitle" role="dialog" tabindex="-1" data-backdrop="static" data-keyboard="false">
                                <div class="modal-dialog modal-simple modal-lg" style="max-width: 1300px">
                                  <div class="modal-content">
                                    <div class="modal-header">
                                      <button type="button" class="close tutup finished" data-dismiss="modal" aria-label="Close">
                                        <span aria-hidden="true">×</span>
                                      </button>
                                      <h4 class="modal-title">Input Penerimaan Alat</h4>
                                    </div>
                                    <div class="modal-body">
                                      <div class="alert alert-danger col-12">
                                        <strong>Perhatian !</strong> Mohon cek kembali data yang anda input sebelum melanjutkan
                                      </div>
                                        <form id="formOrder" novalidate="" class="form-horizontal fv-form fv-form-bootstrap4">

                                          <div class="nav-tabs-horizontal" data-plugin="tabs">
                                            <ul class="nav nav-tabs" role="tablist">
                                              <li class="nav-item" role="presentation"><a class="nav-link active" data-toggle="tab" href="#exampleTabsOne" aria-controls="exampleTabsOne" role="tab">Data Penerimaan Alat</a></li>
                                              <li class="nav-item" role="presentation"><a class="nav-link" data-toggle="tab" href="#exampleTabsTwo" aria-controls="exampleTabsTwo" role="tab">Petugas</a></li>
                                              <li class="dropdown nav-item" role="presentation" style="display: none;">
                                                <a class="dropdown-toggle nav-link" data-toggle="dropdown" href="#" aria-expanded="false">Menu </a>
                                                <div class="dropdown-menu" role="menu">
                                                  <a class="dropdown-item" data-toggle="tab" href="#exampleTabsOne" aria-controls="exampleTabsOne" role="tab">Data Penerimaan Alat</a>
                                                  <a class="dropdown-item" data-toggle="tab" href="#exampleTabsTwo" aria-controls="exampleTabsTwo" role="tab">Petugas</a>
                                                </div>
                                              </li>
                                            </ul>
                                            <div class="tab-content pt-20">
                                              <div class="tab-pane active" id="exampleTabsOne" role="tabpanel">
                                                <div class="row">
                                                  <div class="col-md-4">
                                                    <div class="form-group">
                                                        <label class="control-label">Nomor Order</label>
                                                        <input type="text" class="form-control input-sm" placeholder="Nomor Order" id="no_order" name="no_order" onchange="setOrder(this.value);cek_order(this.value)" data-validate="required" autocomplete="off">
                                                        <span class="badge badge-round badge-warning">Pastikan bahwa nomor order yang anda inputkan sudah benar !</span>
                                                        <input type="hidden" name="id_order" id="id_order">
                                                    </div>
                                                    <div class="form-group">
                                                        <label class="control-label">Tanggal Terima</label>
                                                        <input type="date" class="form-control input-sm" id="tgl_terima" name="tgl_terima" data-validate="required">
                                                    </div>

                                                    <div class="form-group">
                                                        <label class="control-label">Tanggal Selesai</label>
                                                        <input type="date" class="form-control input-sm" id="tgl_selesai" name="tgl_selesai" data-validate="required">
                                                    </div>

                                                    <div class="form-group">
                                                        <label class="control-label">Pemilik</label>
                                                        <input type="text" class="form-control input-sm" placeholder="Pemilik" id="pemilik" name="pemilik" data-validate="required" autocomplete="off">
                                                    </div>

                                                    <div class="form-group">
                                                        <label class="control-label">Status</label>
                                                        <input type="hidden" class="form-control input-sm has-error setatus" id="setatus" name="setatus">
                                                    </div>
                                                  </div>
                                                  <div class="col-md-4">
                                                    <div class="form-group">
                                                        <label class="control-label">Jenis Fasyankes</label>
                                                        <input type="text" class="form-control input-sm has-error jenis" id="jenis" name="jenis">
                                                    </div>
                                                    <div class="form-group">
                                                        <label class="control-label">Provinsi</label>
                                                        <input type="text" class="form-control input-sm has-error provinsi_id" id="provinsi_id" name="provinsi_id">
                                                    </div>
                                                    <div class="form-group">
                                                        <label class="control-label">Kabupaten/Kota</label>
                                                        <input type="text" class="form-control input-sm has-error kabupaten_id" id="kabupaten_id" name="kabupaten_id">
                                                    </div>
                                                    <div class="form-group">
                                                        <label class="control-label">Alamat</label>
                                                        <textarea class="form-control input-sm" name="alamat" placeholder="Alamat" id="alamat" rows="4"></textarea>
                                                    </div>
                                                  </div>

                                                  <div class="col-md-4">
                                                    <div class="form-group">
                                                        <label class="control-label">Telepon/Faksimili</label>
                                                        <input type="text" class="form-control input-sm" placeholder="Telepon/Faksimili" id="telepon" name="telepon" data-validate="required" autocomplete="off">
                                                    </div>

                                                    <div class="form-group">
                                                        <label class="control-label">Contact Person</label>
                                                        <input type="text" class="form-control input-sm" placeholder="Contact Person" id="cp" name="cp" onchange="nama(this.value)" data-validate="required" autocomplete="off">
                                                    </div>

                                                    <div class="form-group">
                                                        <label class="control-label">Handphone</label>
                                                        <input type="text" class="form-control input-sm" placeholder="Handphone" id="hp" name="hp" data-validate="required" autocomplete="off">
                                                    </div>

                                                    <div class="form-group">
                                                        <label class="control-label">Catatan</label>
                                                        <textarea class="form-control input-sm" name="catatan" placeholder="Catatan" id="catatan" rows="4"></textarea>
                                                    </div>

                                                  </div>

                                                </div>

                                              </div>
                                              <div class="tab-pane" id="exampleTabsTwo" role="tabpanel">
                                                <div class="row"> 
                                                  <div class="col-md-4">
                                                      <div class="form-group">
                                                        <label class="control-label">Yang Menyerahkan</label>
                                                        <input type="text" class="form-control input-sm has-error" placeholder="Nama yang Menyerahkan" id="name" name="name" data-validate="required" autocomplete="off">
                                                      </div>

                                                      <div class="form-group">
                                                        <label class="control-label">Penerima Alat</label>
                                                        <input type="hidden" class="form-control input-sm has-error penerima" id="ptg1" name="ptg1">
                                                      </div>

                                                      <div class="form-group">
                                                        <label class="control-label">Pemeriksa Alat</label>
                                                        <input type="hidden" class="form-control input-sm has-error pemeriksa" id="ptg2" name="ptg2">
                                                      </div>

                                                  </div>

                                                  <div class="col-md-4">
                                                      
                                                      <div class="form-group">
                                                        <div class="custom-control custom-checkbox">
                                                            <input type="checkbox" class="custom-control-input cb" name="kup" id="kup">
                                                            <label class="custom-control-label" for="kup">Kaji Ulang Permintaan</label>
                                                        </div>
                                                      </div>

                                                      <div class="form-group">
                                                        <div class="custom-control custom-checkbox">
                                                            <input type="checkbox" class="custom-control-input cb" name="kkl" id="kkl">
                                                            <label class="custom-control-label" for="kkl">Kemampuan Kalibrasi</label>
                                                        </div>
                                                      </div>

                                                      <div class="form-group">
                                                        <div class="custom-control custom-checkbox">
                                                            <input type="checkbox" class="custom-control-input cb" name="kpp" id="kpp">
                                                            <label class="custom-control-label" for="kpp">Kesiapan Petugas</label>
                                                        </div>
                                                      </div>

                                                       <div class="form-group">
                                                        <div class="custom-control custom-checkbox">
                                                            <input type="checkbox" class="custom-control-input cb" name="bpj" id="bpj">
                                                            <label class="custom-control-label" for="bpj">Beban Pekerjaan</label>
                                                        </div>
                                                      </div>

                                                  </div>

                                                  <div class="col-md-4">
                                                      
                                                      <div class="form-group">
                                                        <div class="custom-control custom-checkbox">
                                                            <input type="checkbox" class="custom-control-input cb" name="kpr" id="kpr">
                                                            <label class="custom-control-label" for="kpr">Kondisi Peralatan</label>
                                                        </div>
                                                      </div>

                                                      <div class="form-group">
                                                        <div class="custom-control custom-checkbox">
                                                            <input type="checkbox" class="custom-control-input cb" name="kmk" id="kmk">
                                                            <label class="custom-control-label" for="kmk">Kesesuaian Metode Kalibrasi</label>
                                                        </div>
                                                      </div>

                                                      <div class="form-group">
                                                        <div class="custom-control custom-checkbox">
                                                            <input type="checkbox" class="custom-control-input cb" name="akl" id="akl">
                                                            <label class="custom-control-label" for="akl">Akomodasi & Lingkungan</label>
                                                        </div>
                                                      </div>

                                                  </div>
                                                </div>
                                                <div style="text-align: right;">
                                                  <button type="submit" class="btn btn-round btn-primary btn-pill-right waves-effect waves-classic" id="btn-order" value="add_order">Selesai <i class="icon md-long-arrow-right"></i></button>
                                                </div>
                                              </div>
                                            </div>
                                    </div>

                                    </form>

                                    </div>
                                  </div>
                                  
                                </div>
                              </div>
                              <!-- End Modal -->

                              <div class="modal fade" id="modal-id2">
                                          <div class="modal-dialog" style="max-width: 1300px">
                                              <div class="modal-content">
                                                  <div class="modal-body" style="touch-action: none;">
                                                      <div id="detail"></div>
                                                  </div>
                                                  <div class="modal-footer">
                                                      <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                                                  </div>
                                              </div>
                                          </div>
                                      </div>
                            </div>
                        </div>
                  </div>
                </div>

{!! HTML::script('js/ajax-penerimaanz.js') !!}
@stop
