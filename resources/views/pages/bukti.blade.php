@extends('admin-template')
@section('content')
                  <div class="row">
                    <div class="col-sm-12">
                        <div class="page-title-box">
                            <div class="btn-group pull-right">
                                <ol class="breadcrumb hide-phone p-0 m-0">
                                    <li class="breadcrumb-item"><a href="{{ route('admin.dashboard') }}">LPFK BJB</a></li>
                                    <li class="breadcrumb-item active">Bukti Penyerahan Pekerjaan</li>
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
                                <table class="table table-striped table-bordered" cellspacing="0" width="100%" id="tablebukti">
                                  <thead>
                                    <tr>
                                      <th>No</th>
                                      <th>No Order</th>
                                      <th>Tgl Penyerahan</th>
                                      <th>Pelanggan</th>
                                      <th>Yang Menyerahkan</th>
                                      <th>Yang Menerima</th>
                                      <th>Tahun</th>
                                      <th>Action</th>
                                    </tr>
                                  </thead>
                                  <tfoot>
                                    <tr>
                                      <th>No</th>
                                      <th>No Order</th>
                                      <th>Tgl Penyerahan</th>
                                      <th>Pelanggan</th>
                                      <th>Yang Menyerahkan</th>
                                      <th>Yang Menerima</th>
                                      <th>Tahun</th>
                                      <th>Action</th>
                                    </tr>
                                  </tfoot>
                                </table>

                                <!-- Modal -->
                                  <div class="modal fade modal-rotate-from-bottom" id="myModal" aria-hidden="true" aria-labelledby="exampleModalTitle" role="dialog" tabindex="-1" data-backdrop="static" data-keyboard="false">
                                    <div class="modal-dialog modal-simple" style="max-width: 750px">
                                      <form class="form-horizontal" id="frmbukti" autocomplete="off">
                                      <div class="modal-content">
                                        <div class="modal-header">
                                          <button type="button" class="close tutup" data-dismiss="modal" aria-label="Close">
                                            <span aria-hidden="true">×</span>
                                          </button>
                                          <h4 class="modal-title">Tambah Bukti Penyerahan Pekerjaan</h4>
                                        </div>
                                        <div class="modal-body">
                                            <div class="form-group row form-material">
                                              <label class="col-md-4 form-control-label">No Order</label>
                                              <div class="col-md-8">
                                                <input type="hidden" class="form-control no_order" name="no_order" id="no_order" onchange="reset_alat(this.value)" />
                                              </div>
                                            </div>
                                            <div class="form-group row">
                                              <label class="col-md-4 form-control-label">Alat</label>
                                              <div class="col-md-8">
                                                <input type="text" class="form-control alat_id" name="alat_id[]" multiple/>
                                              </div>
                                            </div>
                                            <div class="form-group row form-material">
                                              <label class="col-md-4 form-control-label">Tgl Penyerahan</label>
                                              <div class="col-md-8">
                                                <input type="date" class="form-control tgl_serah" id="tgl_serah" name="tgl_serah" />
                                              </div>
                                            </div>
                                            <div class="form-group row form-material">
                                              <label class="col-md-4 form-control-label">Yang Menyerahkan</label>
                                              <div class="col-md-8">
                                                <input type="hidden" class="form-control penyerah" id="penyerah" name="penyerah" />
                                              </div>
                                            </div>
                                            <div class="form-group row form-material">
                                              <label class="col-md-4 form-control-label">Yang Menerima</label>
                                              <div class="col-md-8">
                                                <input type="text" class="form-control penerima" id="penerima" name="penerima" autocomplete="off"/>
                                              </div>
                                            </div>
                                            <div class="form-group row form-material">
                                              <label class="col-md-4 form-control-label"></label>
                                              <div class="col-md-8">
                                                <div class="custom-control custom-checkbox">
                                                    <input type="checkbox" class="custom-control-input" name="p1" id="p1">
                                                    <label class="custom-control-label" for="p1">Diserahkan Alat/Barang sesuai dengan daftar di atas</label>
                                                </div>
                                              </div>
                                            </div>
                                            <div class="form-group row form-material">
                                              <label class="col-md-4 form-control-label"></label>
                                              <div class="col-md-8">
                                                <div class="custom-control custom-checkbox">
                                                    <input type="checkbox" class="custom-control-input" name="p2" id="p2">
                                                    <label class="custom-control-label" for="p2">Diserahkan Sertifikat/Lembar hasil Pengujian/Kalibrasi sesuai dengan daftar di atas</label>
                                                </div>
                                              </div>
                                            </div>
                                            <div class="form-group row form-material">
                                              <label class="col-md-4 form-control-label"></label>
                                              <div class="col-md-8">
                                                <div class="custom-control custom-checkbox">
                                                    <input type="checkbox" class="custom-control-input" name="p3" id="p3">
                                                    <label class="custom-control-label" for="p3">Batal diuji/dikalibrasi (dalam keterangan)</label>
                                                </div>
                                              </div>
                                            </div>
                                            <div class="form-group row form-material">
                                              <label class="col-md-4 form-control-label"></label>
                                              <div class="col-md-8">
                                                <div class="custom-control custom-checkbox">
                                                    <input type="checkbox" class="custom-control-input" name="p4" id="p4">
                                                    <label class="custom-control-label" for="p4">Alat/Barang atau Dokumen sudah diperiksa oleh pelanggan</label>
                                                </div>
                                              </div>
                                            </div>
                                        </div>
                                        <div class="modal-footer">
                                          <button type="submit  " class="btn btn-primary" id="btn-save" value="add">Save</button>
                                          <input type="hidden" id="id" name="id" value="0">
                                        </div>
                                      </div>
                                      </form>
                                    </div>
                                  </div>
                                  <!-- End Modal -->
                            </div>

                    </div>
                  </div>
                </div>

{!! HTML::script('js/ajax-bukti.js') !!}
@stop
