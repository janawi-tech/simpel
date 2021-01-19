<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\ViewOrders;
use App\ViewDetailOrders;
use App\VRekapProv;
use App\Customer;
use DB;

class AdminController extends Controller
{
    /**
     * Create a new controller instance.
     *
     * @return void
     */
    public function __construct()
    {
        $this->middleware('auth:admin');
    }

    /**
     * Show the application dashboard.
     *
     * @return \Illuminate\Http\Response
     */
    public function index()
    {
        $jumorder = ViewOrders::where(DB::raw('YEAR(created_at)'),'=',now()->year)->count();
        $jumalat = DB::table('lab_detail_order')->where(DB::raw('YEAR(updated_at)'),'=',now()->year)->count();
        $jumbelum = DB::table('lab_detail_order')
                    ->where(DB::raw('YEAR(updated_at)'),'=',now()->year)
                    ->where('ambil','=',0)
                    ->count();
        $jumselesai = DB::table('lab_detail_order')
                    ->where(DB::raw('YEAR(updated_at)'),'=',now()->year)
                    ->where('ambil','=',1)
                    ->count();

        $list_provinsi=VRekapProv::where('tahun','=',now()->year)->get();
        $RS_Pemerintah=VRekapProv::where('tahun','=',now()->year)->select('RS_Pemerintah')->get();
        $RS_TNI_POLRI=VRekapProv::where('tahun','=',now()->year)->select('RS_TNI_POLRI')->get();
        $RS_BUMN=VRekapProv::where('tahun','=',now()->year)->select('RS_BUMN')->get();
        $RS_Swasta=VRekapProv::where('tahun','=',now()->year)->select('RS_Swasta')->get();
        $Puskesmas=VRekapProv::where('tahun','=',now()->year)->select('Puskesmas')->get();
        $Klinik=VRekapProv::where('tahun','=',now()->year)->select('Klinik')->get();
        $Perusahaan=VRekapProv::where('tahun','=',now()->year)->select('Perusahaan')->get();
        $Lain_Lain=VRekapProv::where('tahun','=',now()->year)->select('Lain_Lain')->get();

        $peta=DB::SELECT('SELECT upper(provinsi) as prop,upper(kabupaten) as name,SUM(tidak_laik_pakai) as value,SUM(laik_pakai) as value2,tahun FROM (SELECT * FROM `v_rekap_kab_final`) as cc WHERE tahun='.date("Y").' GROUP by kabupaten');


        $pie=Customer::where(DB::raw('YEAR(created_at)'),'=',now()->year)
            ->select([
                DB::raw('count(jenis) as value'),
                DB::raw('get_jenis(jenis) as name')
            ])
            ->groupBy('jenis')
            ->get();

        $data='';
        foreach ($pie as $row) {
           $data=$data.'{value:"'.$row->value.'", name:"'.$row->name.'"},' ;
        }

        $datapeta='';
        foreach ($peta as $rowpeta) {
           $datapeta=$datapeta.'{prop:"'.$rowpeta->prop.'", name:"'.$rowpeta->name.'", value:"'.$rowpeta->value.'", value2:"'.$rowpeta->value2.'",x:"'.$rowpeta->value2.'"},' ;
        }
        $datapeta='['.$datapeta.']';

        return view('pages.dashboard')
                ->with('jumorder',$jumorder)
                ->with('jumalat',$jumalat)
                ->with('jumbelum',$jumbelum)
                ->with('jumselesai',$jumselesai)
                ->with('list_provinsi',$list_provinsi)
                ->with('RS_Pemerintah',$RS_Pemerintah)
                ->with('RS_TNI_POLRI',$RS_TNI_POLRI)
                ->with('RS_BUMN',$RS_BUMN)
                ->with('RS_Swasta',$RS_Swasta)
                ->with('Puskesmas',$Puskesmas)
                ->with('Klinik',$Klinik)
                ->with('Perusahaan',$Perusahaan)
                ->with('Lain_Lain',$Lain_Lain)
                ->with('pie',$pie)
                ->with('datapie',$data)
                ->with('petaku',$datapeta);
    }
}
