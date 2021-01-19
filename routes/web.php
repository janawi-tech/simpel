<?php
/*
|--------------------------------------------------------------------------
| Web Routes
|--------------------------------------------------------------------------
|
| Here is where you can register web routes for your application. These
| routes are loaded by the RouteServiceProvider within a group which
| contains the "web" middleware group. Now create something great!
|
*/
Route::get('/', function () {
    return redirect(route('admin.login'));
});
// Route::get('/home', 'HomeController@index')->name('home');

Auth::routes();
// Route::get('/users/logout','Auth\LoginController@userLogout')->name('user.logout');

Route::prefix('lab')->group(function(){
	Route::get('/login', 'Auth\AdminLoginController@showLoginForm')->name('admin.login');
	Route::post('/login', 'Auth\AdminLoginController@login')->name('admin.login.submit');
	Route::get('/', 'AdminController@index')->name('admin.dashboard');
	Route::get('/logout','Auth\AdminLoginController@logout')->name('admin.logout');

	// Route::post('password/email','Auth\AdminForgotPasswordController@sendResetLinkEmail')->name('admin.password.email');
	// Route::get('password/reset','Auth\AdminForgotPasswordController@showLinkRequestForm')->name('admin.password.request');
	// Route::post('password/reset','Auth\AdminResetPasswordController@reset');
	// Route::get('password/reset/{token}','Auth\AdminResetPasswordController@showResetForm')->name('admin.password.reset');
	Route::group(["middleware" => "App\Http\Middleware\AdminMiddleware"], function(){
		Route::get('/pengguna', 'PenggunaController@index')->name('page.pengguna');
		Route::get('pengguna/getdata', 'PenggunaController@getPosts')->name('pengguna/getdata');
		// Route::get('pengguna/getgrid', 'PenggunaController@getGrid')->name('pengguna/getgrid');
		// Route::get('/pengguna/getpengguna','PenggunaController@dataPengguna');
		Route::get('/penggunas/{id?}','PenggunaController@show');
		Route::put('/penggunas/{id?}','PenggunaController@update');

		Route::get('/pengguna/getgroups','PenggunaController@getGroups');
	});
		

	Route::group(["middleware" => "App\Http\Middleware\LabMiddleware"], function(){
		Route::get('/penerimaan', 'PenerimaanController@index')->name('page.penerimaan');
		Route::post('/penerimaans','PenerimaanController@store')->name('penerimaan');
		Route::get('/penerimaans/{id_order}/{no_order?}','PenerimaanController@showOrder');
		Route::put('/penerimaans/{id_order}/{no_order?}','PenerimaanController@updateOrder');
		Route::get('/penerimaan/cek/{no_order}','PenerimaanController@cek')->name('cek');
		Route::delete('/penerimaans/{id_order}/{no_order?}','PenerimaanController@destroyOrder');

		// Route::get('/penerimaans/alat/{no_order?}','PenerimaanController@showAlat');
		// Route::put('/penerimaans/alat/{no_order?}','PenerimaanController@updateAlat');

		Route::get('/penerimaan/form-order', 'ComponentController@showFormOrder')->name('component/form-order');
		Route::get('/penerimaan/form-alat', 'ComponentController@showFormAlat')->name('component/form-alat');
		Route::get('/penerimaan/penerima','PenerimaanController@dataPenerima');
		Route::get('/penerimaan/pemeriksa','PenerimaanController@dataPemeriksa');
		Route::get('/penerimaan/alat','PenerimaanController@dataAlat');
		Route::get('/penerimaan/fungsi','PenerimaanController@dataFungsi');
		Route::get('/penerimaan/setatus','PenerimaanController@dataStatus');
		Route::get('/penerimaan/jenis','PenerimaanController@jenisFasyankes');
		Route::get('/penerimaan/provinsi','PenerimaanController@getProv');
		Route::get('/penerimaan/kabupaten','PenerimaanController@getKab');
		

		Route::get('penerimaan/getorders', 'PenerimaanController@getOrders')->name('penerimaan/getorders');
		Route::post('/details','PenerimaanController@storeDetails')->name('details');
		Route::get('/details/getalat/{id_order}/{no_order?}','PenerimaanController@getAlat');
		Route::get('/details/{alat_id?}','PenerimaanController@show');
		Route::post('/copy-details','PenerimaanController@copyDetails');
		Route::put('/details/{alat_id?}','PenerimaanController@update');
		Route::delete('/details/{alat_id?}','PenerimaanController@destroy');

		Route::get('/cetak/order/{id_order}/{no_order?}',[
	    	'uses' => 'OutputController@cetakOrder',
	    	'as'   => 'order'
		]);

		Route::get('/spk', 'SpkController@index')->name('page.spk');
		Route::get('spk/getdata', 'SpkController@getPosts')->name('spk/getdata');
		Route::post('/spks','SpkController@store')->name('kuitansi');
		Route::get('/spks/{id?}','SpkController@show');
		Route::put('/spks/{id?}','SpkController@update');
		Route::delete('/spks/{id?}','SpkController@destroy');
		Route::get('/spk/order','KuitansiController@dataOrder');
		Route::post('/spks','SpkController@store');
		Route::get('/spk/getalat/{no_order?}','SpkController@dataAlat');
		Route::get('/spk/alat','SpkController@myAlat');
		Route::get('/spk/gettempat','SpkController@dataTempat');
		Route::get('/spk/ka_instalasi','SpkController@ka_instalasi');

		Route::get('/cetak/spk/{id}',[
	    	'uses' => 'OutputController@cetakSPK',
	    	'as'   => 'spk'
		]);

		Route::get('/penyerahan', 'PenyerahanController@index')->name('page.penyerahan');
		Route::get('penyerahan/getdata', 'PenyerahanController@getPosts')->name('penyerahan/getdata');
		Route::post('/penyerahans','PenyerahanController@store')->name('penyerahan');
		Route::get('/penyerahans/{id?}','PenyerahanController@show');
		Route::put('/penyerahans/{id?}','PenyerahanController@update');
		Route::get('/penyerahan/getorder/{no_order}/{petugas_lab}','PenyerahanController@getOrder');
		Route::put('/penyerahan/detail','PenyerahanController@updateDetail');
		Route::delete('/penyerahans/{id?}','PenyerahanController@destroy');
		Route::get('/penyerahan/order','PenyerahanController@dataOrder');
		Route::get('/penyerahan/lab','PenyerahanController@PetugasLab');
		Route::get('/penyerahan/yantek','PenyerahanController@PetugasYantek');

		Route::get('/cetak/penyerahan/{no_order}/{petugas_id}',[
	    	'uses' => 'OutputController@cetakPenyerahan',
	    	'as'   => 'penyerahan'
		]);

		Route::get('/bukti', 'BuktiController@index')->name('page.bukti');
		Route::get('bukti/getdata', 'BuktiController@getPosts')->name('bukti/getdata');
		Route::post('/buktis','BuktiController@store')->name('bukti');
		Route::get('/buktis/{id?}','BuktiController@show');
		Route::put('/buktis/{id?}','BuktiController@update');
		Route::delete('/buktis/{id?}','BuktiController@destroy');
		Route::get('/bukti/penyerah','BuktiController@getPenyerah');
		Route::get('/bukti/getalat/{no_order?}','BuktiController@dataAlat');
		Route::get('/cetak/bukti/{no_order}/{id}',[
	    	'uses' => 'OutputController@cetakBukti',
	    	'as'   => 'bukti'
		]);

		Route::get('/rekap-alat', 'DataController@index')->name('page.rekapalat');
		Route::get('rekap-alat/getdata', 'DataController@getPosts')->name('rekap/getdata');
		Route::get('/lokasi', 'BuktiController@lokasi')->name('page.lokasi');

		Route::get('/cetak/ba/',[
	    	'uses' => 'KosonganController@index',
	    	'as'   => 'bakosong'
		]);

		Route::get('/dokumen', 'DokumenController@index')->name('page.dokumen');
		Route::get('dokumen/getdata', 'DokumenController@getPosts')->name('dokumen/getdata');
		Route::post('/dokumens','DokumenController@store')->name('dokumen');
		Route::delete('/dokumens/{id?}','DokumenController@destroy');
		Route::get('/dokumens/{id?}','DokumenController@show');
		Route::post('/dokumenz/{id?}','DokumenController@update');
	});
		
	Route::group(["middleware" => "App\Http\Middleware\BendaharaMiddleware"], function(){
		Route::get('/kuitansi', 'KuitansiController@index')->name('page.kuitansi');
		Route::get('kuitansi/getdata', 'KuitansiController@getPosts')->name('kuitansi/getdata');
		Route::post('/kuitansis','KuitansiController@store')->name('kuitansi');
		Route::get('/kuitansis/{no_bukti?}','KuitansiController@show');
		Route::put('/kuitansis/{no_bukti?}','KuitansiController@update');
		Route::delete('/kuitansis/{no_bukti?}','KuitansiController@destroy');
		Route::get('/kuitansi/order','KuitansiController@dataOrder');
		Route::get('/kuitansis/customer/{no_order?}','KuitansiController@getCustomer');

		Route::get('/cetak/kuitansi/{no_bukti}',[
	    	'uses' => 'OutputController@cetakKuitansi',
	    	'as'   => 'kuitansi'
		]);
	});
		

	Route::group(["middleware" => "App\Http\Middleware\DataMiddleware"], function(){
		Route::get('/rekap-provinsi', 'RekapController@index')->name('page.rekap-provinsi');
		Route::get('/data-provinsi', 'RekapController@getDataProv')->name('page.data-provinsi');

		Route::get('/rekap-kabupaten', 'RekapController@indexkab')->name('page.rekap-kabupaten');
		Route::get('/data-kabupaten', 'RekapController@getDataKab')->name('page.data-kabupaten');
	});
		

});



