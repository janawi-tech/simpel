<?php

namespace App\Http\Controllers;

use App\DetailPenerimaan;
use App\Laboratorium;
use App\Instalasi;
use App\SPK;
use App\Alat;
use App\ViewSPK;
use App\Orderan;
use Illuminate\Http\Request;
use Yajra\DataTables\DataTables;
use Illuminate\Support\Facades\Input;
use Redirect;
use Response;
use DB;

class SpkController extends Controller
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
        return view('pages.spk');
    }

    public function getPosts()
    {
        $spk = ViewSPK::select([
            'nomor',
            'id',
            'no_order',
            'petugas',
            'kainstalasi',
            'unit_kerja',
            'tahun'
        ]);

        // $spk = Customer::all();

        return DataTables::of($spk)
                ->addColumn('action', function ($spk) {
                    return '
                        <div class="btn-toolbar" aria-label="Toolbar with button groups" role="toolbar">
                            <div class="btn-group" role="group">
                              <button type="button" value="'.$spk->id.'" class="btn btn-icon btn-success waves-effect waves-classic open-modal"><i class="fa fa-edit" aria-hidden="true"></i></button>
                              <button type="button" value="'.$spk->id.'" class="btn btn-icon btn-danger waves-effect waves-classic btn-delete delete-task"><i class="fa fa-trash" aria-hidden="true"></i></button>
                              <a class="btn btn-icon btn-warning waves-effect waves-classic" href="'. route('spk', ['id'=>$spk->id]).'" target="_blank"><i class="fa fa-print" aria-hidden="true"></i></a>
                            </div>
                        </div>
                    ';
                })
                ->rawColumns(['action'])
                ->make(true);
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
            $data = Orderan::findOrFail($request->no_order);
            // var_dump($request->no_order);
            $spk = SPK::create([
                'id_order' => $request->no_order,
                'no_order' => $data->no_order,
                'petugas_id' => $request->petugas_id,
                'unit_kerja' => $request->unit_kerja,
                'alat_id' => json_encode($request->input('alat_id')),
                'tempat' => $request->tempat,
                'ka_instalasi' => $request->ka_instalasi,
                'tgl_spk' => $request->tgl_spk,
                'catatan' => $request->catatan
            ]);
            return Response::json($spk);
        
    }

    /**
     * Display the specified resource.
     *
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function show($id)
    {
        // $spk = SPK::sele($id);
        $spk = SPK::select([
            'id',
            'no_order',
            'alat_id',
            'unit_kerja',
            DB::raw('get_tempat(tempat) as tmpt'),
            DB::raw('get_nama(petugas_id) as petugas'),
            DB::raw('get_kainstalasi(ka_instalasi) kainstalasi'),
            'tempat',
            'petugas_id',
            'ka_instalasi',
            'catatan',
            'tgl_spk'])->where('id', '=', $id)->first();

        $jum=0;
        foreach (count_chars($spk->alat_id,1) as $i => $val) {
            if (chr($i)==",") {
                $jum=$val;
            }
        }

        $alats=explode(",", $spk->alat_id);

        $alatku=array();
        for ($n=0; $n <$jum+1 ; $n++) { 
            array_push($alatku, preg_replace("/[^0-9]/","",$alats[$n]));
        }


        $alat=DetailPenerimaan::select([
                'id',
                DB::raw('CONCAT(get_alat(alat_id)," - Seri :",seri) as text')
            ])
            ->where('no_order','=',$spk->no_order)
            ->whereIn('id',$alatku)
            ->get();


        return Response::json([
            'id'=>$spk->id,
            'no_order'=>$spk->no_order,
            'petugas_id'=>$spk->petugas_id,
            'petugas'=>$spk->petugas,
            'unit_kerja'=>$spk->unit_kerja,
            'alat_id'=>$alat,
            'tempat'=>$spk->tempat,
            'tmpt'=>$spk->tmpt,
            'ka_instalasi'=>$spk->ka_instalasi,
            'kainstalasi'=>$spk->kainstalasi,
            'tgl_spk'=>$spk->tgl_spk,
            'catatan'=>$spk->catatan
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

    /**
     * Update the specified resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function update(Request $request, $id)
    {
        $spk = SPK::find($id);
        $spk->no_order = $request->no_order;
        $spk->petugas_id = $request->petugas_id;
        $spk->unit_kerja = $request->unit_kerja;
        $spk->alat_id = json_encode($request->input('alat_id'));
        $spk->tempat = $request->tempat;
        $spk->ka_instalasi = $request->ka_instalasi;
        $spk->tgl_spk = $request->tgl_spk;
        $spk->catatan = $request->catatan;
        $spk->save();

        return Response::json($spk);
    }

    /**
     * Remove the specified resource from storage.
     *
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function destroy($id)
    {
        $spk = SPK::destroy($id);
        return Response::json($spk);
    }

    public function dataAlat($id_order)
    {
        $spk = SPK::where('id_order','=', $id_order)->get();

        $tools='';
        foreach ($spk as $row) {
            $tools=$tools.','.$row->alat_id;
        }

        $jum=0;
        foreach (count_chars($tools,1) as $i => $val) {
            if (chr($i)==",") {
                $jum=$val;
            }
        }

        $alats=explode(",", $tools);

        $alatku=array();
        for ($n=0; $n <$jum+1 ; $n++) { 
            array_push($alatku, preg_replace("/[^0-9]/","",$alats[$n]));
        }

        // var_dump($alatku);
        // var_dump($no_order);
        // $search = $request->q;
        // $no_order = $request->n;
        $alat=DetailPenerimaan::select([
                'id as id',
                DB::raw('CONCAT(get_alat(alat_id)," - Seri :",seri) as text')
            ])
            ->where('id_order','=',$id_order)
            ->whereNotIn('id',$alatku)
            ->orderBy(DB::raw('get_alat(alat_id)'),'ASC')
            ->get();

        return Response::json($alat);
    }

    public function dataTempat(Request $request)
    {
        $search = $request->q;
        $lab = Laboratorium::where('laboratorium','LIKE',"%$search%")
                    ->select('id','laboratorium')
                    ->orderBy('id', 'asc')
                    ->get();
        return Response::json($lab);
    }

    public function myAlat(Request $request)
    {
        $search = $request->q;
        $no_order = $request->n;

        $spk = SPK::where('no_order','=', $no_order)->get();

        $tools='';
        foreach ($spk as $row) {
            $tools=$tools.','.$row->alat_id;
        }

        $jum=0;
        foreach (count_chars($tools,1) as $i => $val) {
            if (chr($i)==",") {
                $jum=$val;
            }
        }

        $alats=explode(",", $tools);

        $alatku=array();
        for ($n=0; $n <$jum+1 ; $n++) { 
            array_push($alatku, preg_replace("/[^0-9]/","",$alats[$n]));
        }

        $alat=DetailPenerimaan::select([
                'id',
                DB::raw('get_alat(alat_id) as text')
            ])
            ->where('no_order','=',$no_order)
            ->whereNotIn('id',$alatku)
            ->orderBy(DB::raw('get_alat(alat_id)'),'ASC')
            ->get();

        return Response::json($alat);
    }

    public function ka_instalasi(Request $request)
    {
        $search = $request->q;
        $instalasi = Instalasi::where('nama','LIKE',"%$search%")
                    ->select('id','nama')
                    ->orderBy('id', 'asc')
                    ->get();
        return Response::json($instalasi);
    }

    public function dataOrder(Request $request)
    {
        $search = $request->q;
        $order = Orderan::where('no_order','LIKE',"%$search%")
                    ->select('no_order')
                    ->orderBy('no_order', 'desc')
                    ->get();
        return Response::json($order);
    }
}
