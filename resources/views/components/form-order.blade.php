                        <div class="modal-body">
                          <div class="alert alert-danger col-12">
                            <strong>Perhatian !</strong> Mohon cek kembali data yang anda input sebelum melanjutkan
                          </div>
            
                        <div class="panel-group panel-group-simple mb-0" id="exampleAccordion" aria-multiselectable="true" role="tablist">
                          <div class="panel">
                            <div class="panel-heading" id="exampleHeadingOne" role="tab">
                              <a class="panel-title collapsed" data-parent="#exampleAccordion" data-toggle="collapse" href="#exampleCollapseOne" aria-controls="exampleCollapseOne" aria-expanded="false">
                              <h3 class="example-title">Data Penerimaan Alat</h3>
                            </a>
                            </div>
                            <div class="panel-collapse" id="exampleCollapseOne" aria-labelledby="exampleHeadingOne" role="tabpanel" style="">
                              <div class="panel-body">
                                
                                {{-- penerimaan --}}
                                <div class="row">
                                        <div class="col-lg-4">
                                          <div class="form-group row form-material">
                                        <div class="col-12">
                                          <input type="text" class="form-control input-sm" id="no_order" name="no_order" value="1200" data-validate="required">
                                        </div>
                                      </div>
                                      <div class="form-group row form-material">
                                        <div class="col-12">
                                          <input type="date" class="form-control input-sm" id="tgl_terima" name="tgl_terima" data-validate="required">
                                        </div>
                                      </div>
                                      <div class="form-group row form-material">
                                        <div class="col-12">
                                          <input type="date" class="form-control input-sm" id="tgl_selesai" name="tgl_selesai" data-validate="required">
                                        </div>
                                      </div>
                                        </div>
                                        <div class="col-lg-4">
                                      <div class="form-group row form-material">
                                        <div class="col-12">
                                          <input type="text" class="form-control input-sm" placeholder="Pemilik" id="pemilik" name="pemilik" data-validate="required">
                                        </div>
                                      </div>
                                      <div class="form-group row form-material">
                                        <div class="col-12">
                                          <textarea class="form-control input-sm" name="alamat" id="alamat" rows="4">Alamat</textarea>
                                        </div>
                                      </div>
                                        </div>
                                        <div class="col-lg-4">
                                      <div class="form-group row form-material">
                                        <div class="col-12">
                                          <input type="text" class="form-control input-sm" placeholder="Telepon/Faksimili" id="telepon" name="telepon" data-validate="required">
                                        </div>
                                      </div>
                                      <div class="form-group row form-material">
                                        <div class="col-12">
                                          <input type="text" class="form-control input-sm" placeholder="Contact Person" id="cp" name="cp" data-validate="required">
                                        </div>
                                      </div>
                                      <div class="form-group row form-material">
                                        <div class="col-12">
                                          <input type="text" class="form-control input-sm" placeholder="Handphone" id="hp" name="hp" data-validate="required">
                                        </div>
                                      </div>
                                        </div>
                                </div>

                              </div>
                            </div>
                            </div>
                            <div class="panel">
                              <div class="panel-heading" id="exampleHeadingTwo" role="tab">
                                <a class="panel-title collapsed" data-parent="#exampleAccordion" data-toggle="collapse" href="#exampleCollapseTwo" aria-controls="exampleCollapseTwo" aria-expanded="false">
                                <h3 class="example-title">Petugas</h3>
                              </a>
                              </div>
                              <div class="panel-collapse" id="exampleCollapseTwo" aria-labelledby="exampleHeadingTwo" role="tabpanel">
                                <div class="panel-body">
                                  <div class="row">
                                    <div class="col-md-4">
                                      <div class="form-group row form-material">
                                        <div class="col-12">
                                          <input type="text" class="form-control input-sm has-error" placeholder="Nama yang Menyerahkan" id="nama_serah" name="nama_serah" data-validate="required">
                                        </div>
                                      </div>
                                      <div class="form-group">
                                        <div class="">
                                          <input type="hidden" class="form-control input-sm has-error penerima" id="penerima" name="penerima">
                                        </div>
                                      </div>
                                      <div class="form-group">
                                        <div class="">
                                          <input type="hidden" class="form-control input-sm has-error pemeriksa" id="pemeriksa" name="pemeriksa">
                                        </div>
                                      </div>
                                    </div>
                                    <div class="col-md-3">
                                      <div class="form-group">
                                        <div class="checkbox-custom checkbox-primary">
                                                  <input type="checkbox" id="inputkup">
                                                  <label for="inputkup">Kaji Ulang Permintaan</label>
                                                </div>
                                      </div>
                                      <div class="form-group">
                                        <div class="checkbox-custom checkbox-primary">
                                                  <input type="checkbox" id="inputkkl">
                                                  <label for="inputkkl">Kemampuan Kalibrasi</label>
                                                </div>
                                      </div>
                                      <div class="form-group">
                                        <div class="checkbox-custom checkbox-primary">
                                                  <input type="checkbox" id="inputkp">
                                                  <label for="inputkp">Kesiapan Petugas</label>
                                                </div>
                                      </div>
                                      <div class="form-group">
                                        <div class="checkbox-custom checkbox-primary">
                                                  <input type="checkbox" id="inputbp">
                                                  <label for="inputbp">Beban Pekerjaan</label>
                                                </div>
                                      </div>
                                    </div>
                                    <div class="col-md-3">
                                      <div class="form-group">
                                        <div class="checkbox-custom checkbox-primary">
                                                  <input type="checkbox" id="inputkpr">
                                                  <label for="inputkpr">Kondisi Peralatan</label>
                                                </div>
                                      </div>
                                      <div class="form-group">
                                        <div class="checkbox-custom checkbox-primary">
                                                  <input type="checkbox" id="inputkmk">
                                                  <label for="inputkmk">Kesesuaian Metode Kalibrasi</label>
                                                </div>
                                      </div>
                                      <div class="form-group">
                                        <div class="checkbox-custom checkbox-primary">
                                                  <input type="checkbox" id="inputakl">
                                                  <label for="inputakl">Akomodasi & Lingkungan</label>
                                                </div>
                                      </div>
                                    </div>
                                </div>
                                </div>
                              </div>
                            </div>
                        </div>


                        </div>
                        <div class="modal-footer">
                          <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                          <button type="submit" class="btn btn-round btn-primary btn-pill-right waves-effect waves-classic" id="btn-order" value="add_order">Input Alat <i class="icon md-long-arrow-right"></i></button>
                        </div>