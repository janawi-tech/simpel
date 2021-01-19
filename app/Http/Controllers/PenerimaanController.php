<?php

namespace App\Http\Controllers;

use App\ViewOrders;
use App\Fungsi;
use App\Petugas;
use App\Alat;
use App\Orderan;
use App\Customer;
use App\Setatus;
use App\Jenis;
use App\Provinsi;
use App\Kabupaten;
use App\Bukti;
use App\SPK;
use App\Penyerahan;
use App\Kuitansi;
use App\DetailPenerimaan;
use App\PetugasPenerimaan;
use Illuminate\Http\Request;
use Yajra\DataTables\DataTables;
use Redirect;
use Response;
use DB;

class PenerimaanController extends Controller
{
    public function __construct()
    {
        $this->middleware('auth:admin');
    }


    /**
     * Display a listing of the resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function index()
    {
        return view('pages.penerimaan');
    }

    public function getOrders()
    {
        $orders = ViewOrders::select([
            'no',
            'id',
            'no_order',
            'pemilik',
            'setatus',
            'tgl_terima',
            'tgl_selesai',
            'penerima',
            'pemeriksa'
        ])->orderBy('created_at','desc');
        // $detailpenerimaan = DetailPenerimaan::where('no_order','=',$no_order);
        return DataTables::of($orders)
                ->addColumn('setatus', function ($orders) {
                    if ($orders->setatus=="Negeri") {
                        return '<span class="badge badge-info">'.$orders->setatus.'</span>';
                    }else{
                        return '<span class="badge badge-warning">'.$orders->setatus.'</span>';
                    }
                    
                })
                ->addColumn('penerima', function ($orders) {
                    return '<span class="badge badge-danger">'.$orders->penerima.'</span>';
                })
                ->addColumn('pemeriksa', function ($orders) {
                    return '<span class="badge badge-success">'.$orders->pemeriksa.'</span>';
                })
                ->addColumn('action', function ($orders) {
                    return '
                        <div class="btn-toolbar" aria-label="Toolbar with button groups" role="toolbar">
                            <div class="btn-group" role="group">
                              <button type="button" id="'.$orders->id.'" value="'.$orders->no_order.'" class="data-order btn btn-icon btn-success waves-effect waves-classic"><i class="fa fa-edit" aria-hidden="true"></i> Order</button>
                              <button type="button" id="'.$orders->id.'" value="'.$orders->no_order.'" class="data-alat btn btn-icon btn-info waves-effect waves-classic"><i class="fa fa-edit" aria-hidden="true"></i> Alat</button>
                              <a class="btn btn-icon btn-warning waves-effect waves-classic" href="'. route('order', ['id_order'=>$orders->id,'no_order'=>$orders->no_order]).'" target="_blank"><i class="fa fa-print" aria-hidden="true"></i></a>
                              <button type="button" id="'.$orders->id.'" value="'.$orders->no_order.'" class="btn btn-icon btn-danger waves-effect waves-classic delete-task"><i class="fa fa-trash" aria-hidden="true"></i></button>
                            </div>
                        </div>
                    ';

                })
                ->rawColumns(['action','setatus','penerima','pemeriksa'])
                ->make(true);
    }

    public function getAlat(Request $request,$id_order,$no_order)
    {
        $detailpenerimaan = DetailPenerimaan::select([
            'id',
            'id_order',
            'no_order',
            'alat_id',
            DB::raw('get_alat(alat_id) as alat'),
            DB::raw('concat("Rp ", format( get_tarif(alat_id), 0)) as tarif'),
            'merek',
            'model',
            'seri',
            'jumlah',
            'fungsi',
            DB::raw('get_fungsi(fungsi) as fungsiku'),
            'kelengkapan',
            'keterangan'])->where('no_order', '=', $no_order)
                    ->where('id_order','=',$id_order)
                    ->skip($request->skip)
                    ->take($request->take)
                    ->orderBy(DB::raw('get_alat(alat_id)'),'ASC')
                    ->get();

        
        $jumlah = DetailPenerimaan::where('no_order','=',$no_order)
                    ->where('id_order','=',$id_order)
                    ->skip($request->skip)
                    ->take($request->take)
                    ->count();

        return Response::json([
            'items'=>$detailpenerimaan,
            'count'=>$jumlah
        ]);
    }
    /**
     * Show the form for creating a new resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function create()
    {
        //
    }

    /**
     * Store a newly created resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @return \Illuminate\Http\Response
     */
    public function store(Request $request)
    {
        $tableStatus = DB::select("SELECT `AUTO_INCREMENT` FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_SCHEMA = 'lpfkbjb_dbx' AND TABLE_NAME = 'lab_orderan'");

        foreach ($tableStatus as $tableStatuz) {
            $AUTO_INCREMENT=$tableStatuz->AUTO_INCREMENT;
        }

        $orderan = Orderan::create($request->all());
        $customer = Customer::create([
            'id_order'       => $AUTO_INCREMENT,
            'pemilik'       => $request->pemilik,
            'setatus'       => $request->setatus,
            'jenis'         => $request->jenis,
            'provinsi_id'      => $request->provinsi_id,
            'kabupaten_id'       => $request->kabupaten_id,
            'alamat'       => $request->alamat,
            'telepon'       => $request->telepon,
            'cp'       => $request->cp,
            'hp'       => $request->hp,
            'no_order'       => $request->no_order
        ]);

        $petugas = PetugasPenerimaan::create([
            'id_order'       => $AUTO_INCREMENT,
            'no_order'      => $request->no_order,
            'name'     => $request->name,
            'ptg1'    => $request->ptg1,
            'ptg2'      => $request->ptg2,
            'kup'       => $request->kup,
            'kkl'       => $request->kkl,
            'kpp'       => $request->kpp,
            'bpj'       => $request->bpj,
            'kpr'       => $request->kpr,
            'kmk'       => $request->kmk,
            'akl'       => $request->akl
        ]);
        // $customer = Customer::create($request->all());
        // $petugas = PetugasPenerimaan::create($request->all());

        return Response::json($orderan);
        
        // return Response::json($provinsi);
    }

    public function storeDetails(Request $request)
    {
        $data=$request->all();
        $jumlah=count($request->all());
        $sql="INSERT INTO lab_detail_penerimaan SET ";
        $isi='';
        $m=0;

        foreach ($data as $key => $value) {
            $m++;
            if ($m==$jumlah) {
                $isi=$isi.$key."= '".$value."'";
            }else{
                $isi=$isi.$key."= '".$value."', ";
            }

        }

        $sql=$sql.$isi;

        $detail = DetailPenerimaan::create([
            'id_order' => $request->id_order,
            'no_order' => $request->no_order,
            'alat_id' => $request->alat_id,
            'merek' => $request->merek,
            'model' => $request->model,
            'seri' => $request->seri,
            'jumlah' => $request->jumlah,
            'fungsi' => $request->fungsi,
            'kelengkapan' => $request->kelengkapan,
            'keterangan' => $request->keterangan
        ]);
        return Response::json($detail);
    }

    public function showOrder($id_order,$no_order)
    {

        $orderan = Orderan::where('no_order','=',$no_order)
                    ->where('id','=',$id_order)
                    ->select('id','no_order','tgl_terima','tgl_selesai','catatan')
                    ->first();

        $customer = Customer::where('no_order','=',$no_order)
                    ->where('id_order','=',$id_order)
                    ->select(
                        'pemilik',
                        'alamat',
                        'telepon',
                        'cp',
                        'hp',
                        'setatus as status_id',
                        'jenis as jenis_id',
                        'provinsi_id',
                        'kabupaten_id',
                        DB::raw('get_prov(provinsi_id) as provinsi'),
                        DB::raw('get_kab(kabupaten_id) as kabupaten'),
                        DB::raw('get_jenis(jenis) as jenis'),
                        DB::raw('get_status(setatus) as setatus')
                    )
                    ->first();

        $petugas = PetugasPenerimaan::where('no_order','=',$no_order)
                    ->where('id_order','=',$id_order)
                    ->select('name','ptg1 as penerima_id','ptg2 as pemeriksa_id','kup','kkl','kpp','bpj','kpr','kmk','akl',DB::raw('get_nama(ptg1) as penerima'),DB::raw('get_nama(ptg2) as pemeriksa'))
                    ->first();
        
        return Response::json([
            'id_order'=>$id_order,
            'no_order'=>$orderan->no_order,
            'tgl_terima'=>$orderan->tgl_terima,
            'tgl_selesai'=>$orderan->tgl_selesai,
            'catatan'=>$orderan->catatan,
            'pemilik'=>$customer->pemilik,
            'alamat'=>$customer->alamat,
            'telepon'=>$customer->telepon,
            'cp'=>$customer->cp,
            'hp'=>$customer->hp,
            'setatus_id'=>$customer->status_id,
            'setatus'=>$customer->setatus,
            'jenis'=>$customer->jenis,
            'jenis_id'=>$customer->jenis_id,
            'provinsi_id'=>$customer->provinsi_id,
            'provinsi'=>$customer->provinsi,
            'kabupaten_id'=>$customer->kabupaten_id,
            'kabupaten'=>$customer->kabupaten,
            'name'=>$petugas->name,
            'penerima_id'=>$petugas->penerima_id,
            'pemeriksa_id'=>$petugas->pemeriksa_id,
            'kup'=>$petugas->kup,
            'kkl'=>$petugas->kkl,
            'kpp'=>$petugas->kpp,
            'bpj'=>$petugas->bpj,
            'kpr'=>$petugas->kpr,
            'kmk'=>$petugas->kmk,
            'akl'=>$petugas->akl,
            'penerima'=>$petugas->penerima,
            'pemeriksa'=>$petugas->pemeriksa
        ]);

    }

    /**
     * Display the specified resource.
     *
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function show($id)
    {
       $detailpenerimaan = DetailPenerimaan::where('id','=',$id)
                            ->select([
                                'id',
                                'no_order',
                                'alat_id',
                                DB::raw('get_alat(alat_id) as alat'),
                                'merek',
                                'model',
                                'seri',
                                'jumlah',
                                'fungsi',
                                DB::raw('get_fungsi(fungsi) as fungsiku'),
                                'kelengkapan',
                                'keterangan'])->first();

       return Response::json([
            'id'=>$detailpenerimaan->id,
            'alat_id'=>$detailpenerimaan->alat_id,
            'alat'=>$detailpenerimaan->alat,
            'merek'=>$detailpenerimaan->merek,
            'model'=>$detailpenerimaan->model,
            'seri'=>$detailpenerimaan->seri,
            'jumlah'=>$detailpenerimaan->jumlah,
            'fungsi'=>$detailpenerimaan->fungsi,
            'fungsiku'=>$detailpenerimaan->fungsiku,
            'kelengkapan'=>$detailpenerimaan->kelengkapan,
            'keterangan'=>$detailpenerimaan->keterangan
        ]);
    }

    /**
     * Show the form for editing the specified resource.
     *
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function edit($id)
    {
        //
    }

    public function updateOrder(Request $request,$id_order,$no_order)
    {
        $orderan = Orderan::where('no_order','=',$no_order)->
                    where('id','=',$id_order)
                    ->first();
        $orderan->tgl_terima = $request->tgl_terima;
        $orderan->tgl_selesai = $request->tgl_selesai;
        $orderan->catatan = $request->catatan;
        $orderan->save();

        $customer = Customer::where('no_order','=',$no_order)->
                    where('id_order','=',$id_order)
                    ->first();
        $customer->pemilik=$request->pemilik;
        $customer->alamat=$request->alamat;
        $customer->telepon=$request->telepon;
        $customer->cp=$request->cp;
        $customer->hp=$request->hp;
        $customer->setatus=$request->setatus;
        $customer->jenis=$request->jenis;
        $customer->provinsi_id=$request->provinsi_id;
        $customer->kabupaten_id=$request->kabupaten_id;
        $customer->save();

        $petugas = PetugasPenerimaan::where('no_order','=',$no_order)->
                    where('id_order','=',$id_order)
                    ->first();
        $petugas->name=$request->name;
        $petugas->ptg1=$request->ptg1;
        $petugas->ptg2=$request->ptg2;
        $petugas->kup=$request->kup;
        $petugas->kkl=$request->kkl;
        $petugas->kpp=$request->kpp;
        $petugas->bpj=$request->bpj;
        $petugas->kpr=$request->kpr;
        $petugas->kmk=$request->kmk;
        $petugas->akl=$request->akl;
        $petugas->save();

        return Response::json($orderan);
    }

    /**
     * Update the specified resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function update(Request $request, $id)
    {
        $form=$request->all();
        foreach ($form as $key => $value) {
            DetailPenerimaan::where('id','=', $id)->update([$key => $value]);
        }
    }

    public function destroyOrder($id_order,$no_order)
    {
        $orderan=Orderan::where('no_order',$no_order)->where('id',$id_order)->delete();
        $spk=SPK::where('no_order',$no_order)->where('id_order',$id_order)->delete();
        $customer=Customer::where('no_order',$no_order)->where('id_order',$id_order)->delete();
        $penyerahan=Penyerahan::where('no_order',$no_order)->where('id_order',$id_order)->delete();
        $bukti=Bukti::where('no_order',$no_order)->where('id_order',$id_order)->delete();
        $petugas=PetugasPenerimaan::where('no_order',$no_order)->where('id_order',$id_order)->delete();
        $detail=DetailPenerimaan::where('no_order',$no_order)->where('id_order',$id_order)->delete();

        return Response::json($orderan);
    }

    /**
     * Remove the specified resource from storage.
     *
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function destroy($id)
    {
        $detail = DetailPenerimaan::destroy($id);
        return Response::json($detail);
    }

    public function dataPenerima(Request $request)
    {
        $search = $request->q;
        $penerima = Petugas::where('name','LIKE',"%$search%")
                    ->whereIn('id',[17,18])
                    ->select('id','name')
                    ->orderBy('name', 'asc')
                    ->get();
        return Response::json($penerima);
    }

    public function dataPemeriksa(Request $request)
    {
        $search = $request->q;
        $pemeriksa = Petugas::where('name','LIKE',"%$search%")
                    ->where('groups','=',3)
                    ->select('id','name')
                    ->orderBy('name', 'asc')
                    ->get();
        return Response::json($pemeriksa);
    }


    public function dataAlat(Request $request)
    {
        $search = $request->q;
        $alat = Alat::where('nama','LIKE',"%$search%")
                    ->select('id','nama')
                    ->orderBy('nama', 'asc')
                    ->get();
        return Response::json($alat);
    }

    public function dataFungsi(Request $request)
    {
        $search = $request->q;
        $fungsi = Fungsi::where('fungsi','LIKE',"%$search%")
                    ->select('id','fungsi')
                    ->get();
        return Response::json($fungsi);
    }

    public function dataStatus(Request $request)
    {
        $search = $request->q;
        $setatus = Setatus::where('setatus','LIKE',"%$search%")
                    ->select('id','setatus')
                    ->get();
        return Response::json($setatus);
    }

    public function jenisFasyankes(Request $request)
    {
        $search = $request->q;
        $jenis = Jenis::where('jenis','LIKE',"%$search%")
                    ->select('id','jenis')
                    ->get();
        return Response::json($jenis);
    }

    public function getProv(Request $request)
    {
        $search = $request->q;
        $provinsi = Provinsi::where('name','LIKE',"%$search%")
                    ->select('provinsi_id','name')
                    ->get();
        return Response::json($provinsi);
    }

    public function getKab(Request $request)
    {
        $search = $request->q;
        $provinsi_id = $request->prov;
        $kabupaten = Kabupaten::where('name','LIKE',"%$search%")
                    ->where('provinsi_id','=',$provinsi_id)
                    ->select('kabupaten_id','name')
                    ->get();
        return Response::json($kabupaten);
    }

    public function cek($no_order)
    {
        // $jumlah = Orderan::where('no_order','=',$no_order)
        //             ->where(DB::raw('YEAR(created_at)'),'=',date("Y"))
        //             ->count();

        // var_dump($jumlah);
        // if (Orderan::where('no_order', '=', $no_order)->exists()) {
        //    $message=false;
        // }else{
        //    $message=true;
        // }

        // return Response::json(['pesan'=>$message]);
    }

    public function copyDetails(Request $request)
    {
        $detail = DetailPenerimaan::create([
            'id_order'  => $request->id_order,
            'no_order'  => $request->no_order,
            'alat_id'=>$request->alat_id,
            'alat'=>$request->alat,
            'merek'=>$request->merek,
            'model'=>$request->model,
            'seri'=>$request->seri,
            'jumlah'=>$request->jumlah,
            'fungsi'=>$request->fungsi,
            'fungsiku'=>$request->fungsiku,
            'kelengkapan'=>$request->kelengkapan,
            'keterangan'=>$request->keterangan
        ]);
        return Response::json($detail);
    }
}
