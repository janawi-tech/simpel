<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Elibyy\TCPDF\Facades\TCPDF;
use App\ViewOrders;
use App\PetugasPenerimaan;
use App\DetailPenerimaan;
use App\Penyerahan;
use App\Kuitansi;
use Carbon\Carbon;
use Redirect;
use Response;
use DB;
use Auth;

class OutputController extends Controller
{
    public function __construct()
    {
        $this->middleware('auth:admin');
    }

    public function who_is()
    {
        $who =  DB::table('admins')
                ->where('id','=',auth()->user()->id)
                ->select('name as nama')
                ->first();

        return $who->nama;
    }

    function namahari($tanggal){
    
        //fungsi mencari namahari
        //format $tgl YYYY-MM-DD
        //harviacode.com
        
        $tgl=substr($tanggal,8,2);
        $bln=substr($tanggal,5,2);
        $thn=substr($tanggal,0,4);

        $info=date('w', mktime(0,0,0,$bln,$tgl,$thn));
        
        switch($info){
            case '0': return "Minggu"; break;
            case '1': return "Senin"; break;
            case '2': return "Selasa"; break;
            case '3': return "Rabu"; break;
            case '4': return "Kamis"; break;
            case '5': return "Jumat"; break;
            case '6': return "Sabtu"; break;
        };
        
    }

    public function Terbilang($satuan){
        $huruf = array("","Satu","Dua","Tiga","Empat","Lima","Enam","Tujuh","Delapan","Sembilan","Sepuluh","Sebelas");
            if($satuan<12)
            return " ".$huruf[$satuan];
            else if($satuan<20)
            return $this->Terbilang($satuan-10)." Belas";
            else if($satuan<100)
            return $this->Terbilang($satuan/10)." Puluh".$this->Terbilang($satuan%10);
            elseif($satuan<200)
            return " Seratus".$this->Terbilang($satuan-100);
            elseif($satuan<1000)
            return $this->Terbilang($satuan/100)." Ratus".$this->Terbilang($satuan%100);
            elseif($satuan<2000)
            return "Seribu ".$this->Terbilang($satuan-1000);
            elseif($satuan<1000000)
            return $this->Terbilang($satuan/1000)." Ribu".$this->Terbilang($satuan%1000);
            elseif($satuan<1000000000)
            return $this->Terbilang($satuan/1000000)." Juta".$this->Terbilang($satuan%1000000);
            elseif($satuan>=1000000000)
            echo "hasil terbilang tidak dapat di proses, nilai terlalu besar";
    }
    
    public function tgl_indo($tgl){
        $tanggal = substr($tgl,8,2);
        $bulan = $this->getBulan(substr($tgl,5,2));
        $tahun = substr($tgl,0,4);
        return $tanggal.' '.$bulan.' '.$tahun;       
    }

    public function getBulan($bln){
                switch ($bln){
                    case 1: 
                        return "Januari";
                        break;
                    case 2:
                        return "Februari";
                        break;
                    case 3:
                        return "Maret";
                        break;
                    case 4:
                        return "April";
                        break;
                    case 5:
                        return "Mei";
                        break;
                    case 6:
                        return "Juni";
                        break;
                    case 7:
                        return "Juli";
                        break;
                    case 8:
                        return "Agustus";
                        break;
                    case 9:
                        return "September";
                        break;
                    case 10:
                        return "Oktober";
                        break;
                    case 11:
                        return "November";
                        break;
                    case 12:
                        return "Desember";
                        break;
                }
    }
       
    public function cetakOrder($id_order,$no_order)
    {   
        $pdf = new TCPDF();
        $pdf::setHeaderCallback(function($pdf) {
            // $pdf->SetFont('helvetica', 'B', 20);
            // $pdf->Cell(0, 15, 'Something new right here!!!', 0, false, 'C', 0, '', 0, false, 'M', 'M');
        });
        $pdf::setFooterCallback(function($pdf) {
            $style = array(
                'position' => '',
                'align' => 'L',
                'stretch' => true,
                'fitwidth' => true,
                'hpadding' => 'auto',
                'vpadding' => 'auto',
                'font' => 'helvetica',
                'text' => true,
                'font' => 'helvetica',
                'fontsize' => 5,
                'stretchtext' => 4
            );
            $pdf->SetY(200);
            $pdf->write1DBarcode(Carbon::now()->format('d-m-Y H:i:s').'', 'C128A', 3.5, '', 50, 8, 0.4, $style, 'N');
            $pdf->SetY(198);
            $pdf->SetX(60);
            $pdf->SetFont('helvetica', 3);
            $pdf->writeHTML('<i>*Perhatian :</i>', true, 0, true, 0);

            $pdf->SetY(198);
            $pdf->SetX(75);
            $pdf->SetFont('helvetica', 3);
            $pdf->writeHTML('<i>- Isi berita acara ini telah disetujui oleh pelanggan</i>', true, 0, true, 0);
            $pdf->SetY(201);
            $pdf->SetX(75);
            $pdf->SetFont('helvetica', 3);
            $pdf->writeHTML('<i>- Data sertifikat yang akan diterbitkan sama dengan data yang ada pada berita acara ini</i>', true, 0, true, 0);
            $pdf->SetY(204);
            $pdf->SetX(75);
            $pdf->SetFont('helvetica', 3);
            $pdf->writeHTML('<i>- Tidak dibenarkan memperbanyak, mengutip atau memiliki sebagian/keseluruhan isi dokumen ini tanpa izin dari LPFK Banjarbaru</i>', true, 0, true, 0);
            $pdf->SetY(192);
            $pdf->SetX(23.5);

            $pdf->Cell(533, 25, 'Hal '.$pdf->getAliasNumPage().' dari '.$pdf->getAliasNbPages(), 0, false, 'C', 0, '', 0, false, 'T', 'M');
        });
        $pdf::setFooterFont(Array(PDF_FONT_NAME_DATA, '', PDF_FONT_SIZE_DATA));
        $pdf::SetDefaultMonospacedFont(PDF_FONT_MONOSPACED);
        $pdf::SetAutoPageBreak(TRUE, 11);
        $pdf::SetMargins(5.5, 5.5);
        $pdf::setCellHeightRatio(1);
        $pdf::SetTitle('Cetak Order');
        $pdf::AddPage('L', 'A4');

        $style = array(
            'border' => 0,
            'padding' => 0,
            'fgcolor' => array(0,0,0),
            'bgcolor' => false,//array(255,255,255),
            'module_width' => 1, // width of a single module in points
            'module_height' => 1 // height of a single module in points
        );


        $vieworder = ViewOrders::where('no_order','=',$no_order)->where('id','=',$id_order)->get();
        $i=0;
        foreach ($vieworder as $data) {
            $pemilik=$data->pemilik;
            $alamat=$data->alamat. ', '.$data->kab.' - '.$data->prov;
            $cp=$data->cp;
            $hp=$data->hp;
            $penyerah=$data->penyerah;
            $tgl_terima=$this->tgl_indo($data->tgl_terima);
            $tgl_selesai=$this->tgl_indo($data->tgl_selesai);
            $catatan=$data->catatan;
            $penerima=$data->penerima;
            $pemeriksa=$data->pemeriksa;
            $telepon=$data->telepon;
        }

        $barkode=$this->who_is().'-'.$penerima.'-'.$pemeriksa;
        $params = $pdf::serializeTCPDFtagParameters(array($barkode, 'PDF417', 200, '', 250, 20, $style, 'N'));
        // $params = $pdf::serializeTCPDFtagParameters(array($barkode, 'QRCODE,H', 225, '',20,20, $style, 'N'));
        // Response::json($vieworder);

        $table_order='<table border="1" cellpadding="3" cellspacing="0">
                        <tr>
                            <td rowspan="3" colspan="2" style="text-align:center" width="405px">
                                <img src="img/kop.png" width="320px"/>
                            </td>
                            <td colspan="2" align="center" style="font-size:11px" width="405px">
                                <b>BUKTI PENERIMAAN PEKERJAAN KALIBRASI ALAT KESEHATAN</b>
                            </td>
                        </tr>
                        <tr>
                            <td><font size="8em">Nomor Order : '.$no_order.'</font></td>
                            <td><font size="8em">Tanggal Terima : '.$tgl_terima.'</font></td>
                        </tr>
                        <tr>
                            <td colspan="2"><font size="8em">Pekerjaan diperkirakan selesai tanggal : '.$tgl_selesai.'</font></td>
                        </tr>
                        <tr>
                            <td colspan="2">
                                <table border="0" cellpadding="1.5" cellspacing="0">
                                    <tr>
                                        <td><font size="8em">Pemilik Barang</font></td>
                                        <td width="8px"><font size="8em">:</font></td>
                                        <td width="230px"><font size="8em">'.$pemilik.'</font></td>
                                    </tr>
                                    <tr>
                                        <td><font size="8em">Alamat</font></td>
                                        <td width="8px"><font size="8em">:</font></td>
                                        <td width="230px"><font size="8em">'.$alamat.'</font></td>
                                    </tr>
                                    <tr>
                                        <td><font size="8em">Telepon/Faksimili</font></td>
                                        <td width="8px"><font size="8em">:</font></td>
                                        <td width="230px"><font size="8em">'.$telepon.'</font></td>
                                    </tr>
                                    <tr>
                                        <td><font size="8em">Contact Person:</font></td>
                                        <td width="8px"><font size="8em">:</font></td>
                                        <td width="230px"><font size="8em">'.$cp.'&nbsp;&nbsp;&nbsp;Telp./HP&nbsp;&nbsp;:&nbsp;&nbsp;'.$hp.'</font></td>
                                    </tr>
                                </table>
                            </td>
                            <td colspan="2">
                                <table border="0">
                                    <tr align="center">
                                        <td><font size="8em">Yang Menyerahkan Barang</font></td>
                                        <td colspan="2" rowspan="8"><tcpdf method="write2DBarcode" params="'.$params.'" /></td>
                                    </tr>
                                    <tr><td></td></tr>
                                    <tr><td></td></tr>
                                    <tr><td></td></tr>
                                    <tr><td></td></tr>
                                    <tr align="center"><td><font size="8em">'.$penyerah.'</font></td></tr>
                                </table>
                            </td>
                        </tr>
                    </table>';

        $detailpenerimaan = DetailPenerimaan::select([
            DB::raw('get_alat(alat_id) as alat'),
            DB::raw('concat("Rp ", format( get_tarif(alat_id), 0)) as tarif'),
            'merek',
            'model',
            'seri',
            'jumlah',
            DB::raw('get_fungsi(fungsi) as fungsiku'),
            'kelengkapan',
            'keterangan'])->where('no_order', '=', $no_order)
        ->where('id_order', '=', $id_order)
        ->orderBy(DB::raw('get_alat(alat_id)'),'ASC')
        ->orderBy('merek','ASC')
        ->get();

        $jumlahdetail = DetailPenerimaan::select([
            'alat_id'])->where('no_order', '=', $no_order)->where('id_order', '=', $id_order)->count();

        $isi='';
        $no=0;
        foreach ($detailpenerimaan as $detail) {
            $no++;
            $isi=$isi.'<tr nobr="true">
                            <td width="20px" align="center"><font size="8em">'.$no.'</font></td>
                            <td width="140px" ><font size="8em">'.$detail->alat.'</font></td>
                            <td width="80px" ><font size="8em">'.$detail->merek.'</font></td>
                            <td width="80px" ><font size="8em">'.$detail->model.'</font></td>
                            <td width="85px" ><font size="8em">'.$detail->seri.'</font></td>
                            <td width="50px"  align="center"><font size="8em">'.$detail->jumlah.'</font></td>
                            <td width="60px" ><font size="8em">'.$detail->tarif.'</font></td>
                            <td width="50px" ><font size="8em">'.$detail->fungsiku.'</font></td>
                            <td width="150px" ><font size="8em">'.$detail->kelengkapan.'</font></td>
                            <td width="95px" ><font size="8em">'.$detail->keterangan.'</font></td>
                       </tr>';
        }

       $total=DB::select('select concat("Rp ", format( get_total("'.$no_order.'",'.$id_order.'), 0)) as total');
        foreach ($total as $totalharga) {
            $total=$totalharga->total;
        }

        $detail_kemampuan = PetugasPenerimaan::select([
                'kup',
                'kkl',
                'kpp',
                'bpj',
                'kpr',
                'kmk',
                'akl'
            ])->where('no_order', '=', $no_order)->where('id_order', '=', $id_order)->get();

        foreach ($detail_kemampuan as $details) {
            if ($details->kup ==1){
                $kup='<img src="img/check.png" height="8" />';
            }else{
                $kup='<img src="img/remove.png" height="8" />';
            }
            if ($details->kkl ==1){
                $kkl='<img src="img/check.png" height="8" />';
            }else{
                $kkl='<img src="img/remove.png" height="8" />';
            }
            if ($details->kpp ==1){
                $kpp='<img src="img/check.png" height="8" />';
            }else{
                $kpp='<img src="img/remove.png" height="8" />';
            }
            if ($details->bpj ==1){
                $bpj='<img src="img/check.png" height="8" />';
            }else{
                $bpj='<img src="img/remove.png" height="8" />';
            }
            if ($details->kpr ==1){
                $kpr='<img src="img/check.png" height="8" />';
            }else{
                $kpr='<img src="img/remove.png" height="8" />';
            }
            if ($details->kmk ==1){
                $kmk='<img src="img/check.png" height="8" />';
            }else{
                $kmk='<img src="img/remove.png" height="8" />';
            }
            if ($details->akl ==1){
                $akl='<img src="img/check.png" height="8" />';
            }else{
                $akl='<img src="img/remove.png" height="8" />';
            }
        }        

        $pdf::SetFont('helvetica', '', 9);

        
        $table_det_order=$table_order.'
                    <table border="1" cellpadding="2" cellspacing="0" width="100%">
                        <thead>
                            <tr align="center" nobr="true">
                                <th rowspan="2" width="20px"><font size="8em"><br>No</font></th>
                                <th rowspan="2" width="140px"><font size="8em"><br>Nama Alat</font></th>
                                <th rowspan="2" width="80px"><font size="8em"><br>Merek</font></th>
                                <th rowspan="2" width="80px"><font size="8em"><br>Model/Type</font></th>
                                <th rowspan="2" width="85px"><font size="8em"><br>No. Seri</font></th>
                                <th rowspan="2" width="50px"><font size="8em"><br>Jumlah</font></th>
                                <th rowspan="2" width="60px"><font size="8em"><br>Harga Satuan (Rp)</font></th>
                                <th colspan="2" width="200px"><font size="8em">Pengecekan</font></th>
                                <th rowspan="2" width="95px"><font size="8em">Keterangan</font></th>
                            </tr>
                            <tr align="center">
                                <th width="50px"><font size="8em">Fungsi</font></th>
                                <th width="150px"><font size="8em">Aksesoris</font></th>
                            </tr>
                        </thead>
                        <tbody>
                            '.$isi.'
                            <tr>
                                <td colspan="6" style="text-align:right"><font size="8em">Total</font></td>
                                <td colspan="4" style="text-align:left"><font size="8em">'.$total.'</font></td>
                            </tr>
                        </tbody>
                    </table>';
        $tabelcatat='<table border="1" cellpadding="2" cellspacing="0">
                        <tr>
                            <td colspan="7" rowspan="8" style="text-align:justify" width="565px"><font size="8em">Catatan :<br>'.$catatan.'</font></td>
                            <td colspan="2" width="150px"><font size="8em">Kaji Ulang Permintaan</font></td>
                            <td align="center" width="95">'.$kup.'</td>
                        </tr>
                        <tr>
                            <td colspan="2"><font size="8em">Kemampuan Kalibrasi</font></td>
                            <td align="center">'.$kkl.'</td>
                        </tr>
                        <tr>
                            <td colspan="2"><font size="8em">Kesiapan Petugas</font></td>
                            <td align="center">'.$kpp.'</td>
                        </tr>
                        <tr>
                            <td colspan="2"><font size="8em">Beban Pekerjaan</font></td>
                            <td align="center">'.$bpj.'</td>
                        </tr>
                        <tr>
                            <td colspan="2"><font size="8em">Kondisi Peralatan</font></td>
                            <td align="center">'.$kpr.'</td>
                        </tr>
                        <tr>
                            <td colspan="2"><font size="8em">Kesesuaian Metode Kalibrasi</font></td>
                            <td align="center">'.$kmk.'</td>
                        </tr>
                        <tr>
                            <td colspan="2"><font size="8em">Akomodasi & Lingkungan</font></td>
                            <td align="center">'.$akl.'</td>
                        </tr>
                        <tr>
                            <td colspan="3"><font size="7em">*)Ket : <img src="img/check.png" height="5"/> Memungkinkan &nbsp;&nbsp; *)Ket : <img src="img/remove.png" height="5"/> Tidak Memungkinkan</font></td>
                        </tr>
                        <tr>
                            <td width="810px">
                                <table border="0">
                                    <tr>
                                        <td><font size="8em">Lembar 1&nbsp;&nbsp;:&nbsp;&nbsp;Untuk Pelanggan</font></td>
                                        <td rowspan="2" align="right" style="vertical-align:middle"><font face="courier" size="8em">&nbsp;SOP LPFK.03.12 REV.2</font></td>
                                    </tr>
                                    <tr>
                                        <td><font size="8em">Lembar 2&nbsp;&nbsp;:&nbsp;&nbsp;Untuk Personal Pelayanan Teknis</font></td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                    </table>';

        // if ($jumlahdetail>=20) {
        //     $pdf::writeHTML($table_det_order.$tabelcatat, true, false, true, false, '');
        //     $pdf::AddPage('L', 'A4');
        //     $pdf::SetFont('helvetica', '', 9);
        //     $pdf::SetY(5);
        //     $pdf::SetX(5.5);
        //     $pdf::writeHTML($tabelcatat, true, false, true, false, '');
        // }else{
            $pdf::writeHTML($table_det_order.$tabelcatat, true, false, true, false, '');
        // }
        
        
        // $pdf::write2DBarcode($barkode, 'QRCODE,H', 220, 37, 25, 25, $style, 'N');
        // $pdf::write2DBarcode($barkode, 'QRCODE,H', 177, 16, 25, 25, $style, 'N');
        $pdf::lastPage();
        $pdf::Output('bukti-order-'.$no_order.'.pdf');
    }

    public function cetakKuitansi($no_order){
        $pdf = new TCPDF();
        $pdf::setHeaderCallback(function($pdf) {
            // $pdf->SetFont('helvetica', 'B', 20);
            // $pdf->Cell(0, 15, 'Something new right here!!!', 0, false, 'C', 0, '', 0, false, 'M', 'M');
        });
        $pdf::setFooterCallback(function($pdf) {
            // $pdf->SetY(-15);
            // $pdf->SetFont('helvetica', 'I', 8);
            // $pdf->Cell(373, 10, 'Hal '.$pdf->getAliasNumPage().' dari '.$pdf->getAliasNbPages(), 0, false, 'C', 0, '', 0, false, 'T', 'M');
        });
        $style4 = array('width' => 0.75, 'cap' => 'butt', 'join' => 'miter', 'dash' => 0, 'color' => array(128, 128, 128));
        $style3 = array('width' => 0.40, 'cap' => 'butt', 'join' => 'miter', 'dash' => 0, 'color' => array(0, 0, 0));
        $style2 = array('width' => 0.75, 'cap' => 'butt', 'join' => 'miter', 'dash' => 0, 'color' => array(0, 0, 0));
        // set style for barcode
        $style = array(
            'border' => 0,
            'vpadding' => 'auto',
            'hpadding' => 'auto',
            'fgcolor' => array(0,0,0),
            'bgcolor' => false,//array(255,255,255),
            'module_width' => 1, // width of a single module in points
            'module_height' => 1 // height of a single module in points
        );
        $pdf::setFooterFont(Array(PDF_FONT_NAME_DATA, '', PDF_FONT_SIZE_DATA));
        $pdf::SetDefaultMonospacedFont(PDF_FONT_MONOSPACED);
        
        $pdf::SetTitle('Kuitansi-'.$no_order);
        $pdf::AddPage('P', 'A4');
        $pdf::SetFont('helvetica', '', 11);

        $kuitansi = Kuitansi::select([
            'no_bukti',
            'no_order',
            DB::raw('get_total(no_order) as terbilang'),
            DB::raw('concat("Rp ", format( get_total(no_order), 0)) as total'),
            'tgl_bayar',
            DB::raw('get_customer(no_order) as customer'),
            'dari',
            'keterangan'])->where('no_order', '=', $no_order)->get();

        foreach ($kuitansi as $data_kuitansi) {
           $no_bukti=$data_kuitansi->no_bukti;
           $no_order=$data_kuitansi->no_order;
           $terbilang=$this->Terbilang($data_kuitansi->terbilang);
           $total=$data_kuitansi->total;
           $tgl_bayar=$this->tgl_indo($data_kuitansi->tgl_bayar);
           $customer=$data_kuitansi->customer;
           $dari=$data_kuitansi->dari;
           $keterangan=$data_kuitansi->keterangan;
        }

        $table_kuitansi='<table border="0">
                            <tr>
                                <td width="390px" colspan="8"></td>
                                <td width="70px;"><font size="10em">TA</font></td>
                                <td width="4px"><font size="10em">:</font></td>
                                <td width="70px"><font size="10em">'.now()->year.'</font></td>
                            </tr>
                            <tr>
                                <td colspan="8"></td>
                                <td width="70px;"><font size="10em">Nomor Bukti</font></td>
                                <td width="4px"><font size="10em">:</font></td>
                                <td><font size="10em">'.$no_bukti.'</font></td>
                            </tr>
                            <tr>
                                <td colspan="11" align="center"><font size="15em"><b>KUITANSI</b></font></td>
                            </tr>
                        </table>
                        <table border="0">
                            <tr><td colspan="11"></td></tr>
                            <tr>
                                <td colspan="2"><font size="10em">Sudah terima dari</font></td>
                                <td width="4px"><font size="10em">:</font></td>
                                <td width="437px" colspan="8" align="left" bgcolor="#d3d3d3"><font size="10em">'.$customer.'</font></td>
                            </tr>
                            <tr><td colspan="11"></td></tr>
                            <tr>
                                <td colspan="2"><font size="10em">Jumlah Uang</font></td>
                                <td width="4px"><font size="10em">:</font></td>
                                <td colspan="8" align="left" bgcolor="#d3d3d3"><font size="10em">'.$total.'</font></td>
                            </tr>
                            <tr><td colspan="11"></td></tr>
                            <tr>
                                <td colspan="2"><font size="10em">Terbilang</font></td>
                                <td width="4px"><font size="10em">:</font></td>
                                <td colspan="8" align="left"><font face="courier" size="10em"># '.$terbilang.' Rupiah #</font></td>
                            </tr>
                            <tr><td colspan="11"></td></tr>
                            <tr>
                                <td colspan="2"><font size="10em">Untuk Pembayaran</font></td>
                                <td width="4px"><font size="10em">:</font></td>
                                <td colspan="8" style="text-align:justify"><font size="10em">'.$keterangan.'</font></td>
                            </tr>
                        </table>
                        <table border="0">
                            <tr>
                                <td colspan="11">
                                    <p style="text-align:justify"><font size="10em">(Biaya tersebut sesuai Pola Tarif PP No. 21 Tahun 2013, Tentang jenis dan Tarif Atas Jenis Penerimaan Negara Bukan Pajak yang berlaku pada Kementerian Kesehatan RI)</font></p>
                                </td>
                            </tr>
                            <tr><td colspan="11"></td></tr>
                        </table>
                        <table border="0">
                            <tr>
                                <td colspan="5"><font size="10em">Lunas Dibayar</font></td>
                                <td colspan="4" align="right"><font size="10em">Banjarbaru, '.$tgl_bayar.'</font></td>
                                <td colspan="2"></td>
                            </tr>
                            <tr>
                                <td colspan="5"><font size="10em">Tanggal : '.$tgl_bayar.'</font></td>
                                <td colspan="4" align="right"><font size="10em">Bendahara Penerimaan</font></td>
                                <td colspan="2"></td>
                            </tr>
                            <tr><td colspan="11"></td></tr>
                            <tr><td colspan="11"></td></tr>
                            <tr><td colspan="11"></td></tr>
                            <tr><td colspan="11"></td></tr>

                            <tr>
                                <td colspan="5"><font size="10em">'.$dari.'</font></td>
                                <td colspan="4" align="right"><u><font size="10em">SRI MAWARNI, SE</font></u></td>
                                <td colspan="2"></td>
                            </tr>
                            <tr>
                                <td colspan="9" align="right"><font size="10em">NIP. 198610172009122001</font></td>
                            </tr>
                        </table>';

        $pdf::image('img/head.jpg', 6, 8, 198,'', 'jpg', '', 'T', false, 300, '', false, false, 0, false, false, false);
        $pdf::SetX(8);
        $pdf::SetY(50);
        $pdf::Line(11, 45, 198, 45, $style3);
        $pdf::Line(11, 44, 198, 44, $style2);
        $pdf::writeHTML($table_kuitansi, true, false, true, false, '');
        $pdf::lastPage();
        $pdf::Output('kuitansi-'.$no_bukti.'-'.Carbon::now()->toDateTimeString().'pdf');
    }

    public function cetakSPK($id)
    {
        $pdf = new TCPDF();
        $pdf::setHeaderCallback(function($pdf) {
            // $pdf->SetFont('helvetica', 'B', 20);
            // $pdf->Cell(0, 15, 'Something new right here!!!', 0, false, 'C', 0, '', 0, false, 'M', 'M');
        });
        $pdf::setFooterCallback(function($pdf) {
            // $pdf->SetY(-15);
            // $pdf->SetFont('helvetica', 'I', 8);
            // $pdf->Cell(373, 10, 'Hal '.$pdf->getAliasNumPage().' dari '.$pdf->getAliasNbPages(), 0, false, 'C', 0, '', 0, false, 'T', 'M');
        });
        $pdf::setFooterFont(Array(PDF_FONT_NAME_DATA, '', PDF_FONT_SIZE_DATA));
        $pdf::SetDefaultMonospacedFont(PDF_FONT_MONOSPACED);
        // $pdf::SetMargins(PDF_MARGIN_LEFT, PDF_MARGIN_BOTTOM, PDF_MARGIN_RIGHT);
        $pdf::SetHeaderMargin(PDF_MARGIN_HEADER);
        $pdf::SetFooterMargin(PDF_MARGIN_FOOTER);
        $pdf::setCellHeightRatio(1);
        $pdf::SetTitle('Cetak SPK');
        $pdf::AddPage('P', 'A4');
        $pdf::SetFont('helvetica', '', 11);
        $style = array(
            'border' => 0,
            'vpadding' => 'auto',
            'hpadding' => 'auto',
            'fgcolor' => array(0,0,0),
            'bgcolor' => false,//array(255,255,255),
            'module_width' => 1, // width of a single module in points
            'module_height' => 1 // height of a single module in points
        );
      

        $spk_atas =  DB::table('lab_spk')
                    ->join('admins', 'lab_spk.petugas_id', '=', 'admins.id')
                    ->join('lab_admins_group', 'admins.groups', '=', 'lab_admins_group.id')
                    ->join('lab_instalasi', 'lab_spk.ka_instalasi', '=', 'lab_instalasi.id')
                    ->where('lab_spk.id', $id)
                    ->select(
                        'lab_spk.no_order',
                        'lab_spk.alat_id',
                        'lab_spk.tgl_spk',
                        'lab_spk.catatan',
                        'admins.nip as nip_petugas',
                        'lab_instalasi.nama as ka',
                        'lab_instalasi.nip as nip_ka',
                        'admins.name as nama',
                        'lab_admins_group.groups as jabatan',
                        'lab_spk.unit_kerja as unit_kerja'
                    )
                    ->get();

        foreach ($spk_atas as $data) {
            $nama=$data->nama;
            $ka=$data->ka;
            $nip_petugas=$data->nip_petugas;
            $nip_ka=$data->nip_ka;
            $jabatan=$data->jabatan;
            $unit_kerja=$data->unit_kerja;
            $alat_id=$data->alat_id;
            $no_order=$data->no_order;
            $tgl_spk=$data->tgl_spk;
            $catatan=$data->catatan;
        }

        $table_spk='<table border="0" cellpadding="0" cellspacing="0">
                        <tr align="right">
                            <td colspan="5"><font face="courier" size="9em">F-5.8c Rev.3</font></td>
                        </tr>
                        <tr align="left">
                            <td width="40px"><img src="img/logo.png" height="55" /></td>
                            <td colspan="5" width="493px">
                                <font size="12em">Kementerian Kesehatan RI</font><br>
                                <font size="9em">Direktorat Jenderal Pelayanan Kesehatan</font><br>
                                <font size="8em">Loka Pengamanan Fasilitas Kesehatan Banjarbaru</font>
                            </td>
                        </tr>
                        <tr><td colspan="5" width="533px"></td></tr>
                        <tr align="center">
                            <td colspan="5" width="533px"><font size="12em"><u><b>SURAT PERINTAH KERJA</b></u></font></td>
                        </tr>
                        <tr><td colspan="5"></td></tr>
                        <tr align="left">
                            <td colspan="5"><font size="8em">Diperintahkan kepada yang tersebut di bawah ini :</font></td>
                        </tr>
                        <tr align="left">
                            <td width="102px"><font size="8em">Nama</font></td>
                            <td width="4px"><font size="8em">:</font></td>
                            <td width="427px" colspan="3"><font size="8em">'.$nama.'</font></td>
                        </tr>
                        <tr align="left">
                            <td><font size="8em">NIP</font></td>
                            <td width="4px"><font size="8em">:</font></td>
                            <td width="427px" colspan="3"><font size="8em">'.$nip_petugas.'</font></td>
                        </tr>
                        <tr align="left">
                            <td><font size="8em">Jabatan</font></td>
                            <td width="4px"><font size="8em">:</font></td>
                            <td width="427px" colspan="3"><font size="8em">'.$jabatan.'</font></td>
                        </tr>
                        <tr align="left">
                            <td><font size="8em">Unit Kerja</font></td>
                            <td width="4px"><font size="8em">:</font></td>
                            <td width="427px" colspan="3"><font size="8em">'.$unit_kerja.'</font></td>
                        </tr>
                        <tr align="left">
                            <td colspan="5"><font size="8em">Untuk melaksanakan tugas sebagai berikut :</font></td>
                        </tr>
                        <tr><td colspan="5"></td></tr>
                    </table>';



        $jum=0;
        foreach (count_chars($alat_id,1) as $i => $val) {
            if (chr($i)==",") {
                $jum=$val;
            }
        }

        $alats=explode(",", $alat_id);

        $alatku=array();
        for ($n=0; $n <$jum+1 ; $n++) { 
            array_push($alatku, preg_replace("/[^0-9]/","",$alats[$n]));
        }


        $alat=DetailPenerimaan::select([
                DB::raw('get_alat(alat_id) as kegiatan'),
                'seri',
                'no_order'
            ])
            ->where('no_order','=',$no_order)
            ->whereIn('id',$alatku)
            ->orderBy(DB::raw('get_alat(alat_id)'),'ASC')
            ->get();

        $isi='';
        $no=0;
        foreach ($alat as $detail) {
            $no++;
            $isi=$isi.'<tr>
                            <td width="30px" style="text-align:center"><font size="8em">'.$no.'</font></td>
                            <td width="225px"><font size="8em">'.$detail->kegiatan.'</font></td>
                            <td><font size="8em">'.$detail->seri.'</font></td>
                            <td width="149px"><font size="8em">'.$detail->no_order.'</font></td>
                        </tr>';
        }

        $table_det_spk=$table_spk.'<table border="1" cellpadding="2" cellspacing="0">
                        <thead>
                            <tr align="center">
                                <th width="30px"><font size="8em">No</font></th>
                                <th width="225px"><font size="8em">Kegiatan</font></th>
                                <th><font size="8em">Nomor Seri</font></th>
                                <th width="149px"><font size="8em">Keterangan</font></th>
                            </tr>
                        </thead>
                        <tbody>
                        '.$isi.'
                        <tr>
                            <td colspan="4"><font size="8em">Catatan : '.$catatan.'</font></td>
                        </tr>
                        </tbody>
                    </table>';
        $barkode=$this->who_is().'-'.Carbon::now()->format('d-m-Y').$ka.$nip_ka;
        $params = $pdf::serializeTCPDFtagParameters(array($barkode, 'QRCODE,H', 149, '', 30, 30, $style, 'N'));
        $table_ttd=$table_det_spk.'<table border="0">
                        <tr><td colspan="5"></td></tr>
                        <tr>
                            <td colspan="3" width="400px"></td>
                            <td colspan="2" width="138px"><font size="8em">Banjarbaru, '.$this->tgl_indo($tgl_spk).'</font></td>
                        </tr>
                        <tr>
                            <td colspan="3"></td>
                            <td colspan="2"><font size="8em">Kepala Instalasi Laboratorium Pengujian & Kalibrasi</font></td>
                        </tr>
                        <tr>
                            <td colspan="3"></td>
                            <td colspan="2"><tcpdf method="write2DBarcode" params="'.$params.'" /></td>
                        </tr>
                    </table>';

        
        $pdf::SetY(8);            
        $pdf::writeHTML($table_ttd, true, false, true, false, '');
        // $pdf::write1DBarcode($barkode, 'C128', 122, '', '', 18, 0.4, $style, 'N');
        $pdf::lastPage();
        $pdf::Output('SPK-'.$id.'-'.Carbon::now()->toDateTimeString().'pdf');
    }

    public function cetakPenyerahan($id_order,$petugas_id)
    {
        $pdf = new TCPDF();
        $pdf::setHeaderCallback(function($pdf) {
            // $pdf->SetFont('helvetica', 'B', 20);
            // $pdf->Cell(0, 15, 'Something new right here!!!', 0, false, 'C', 0, '', 0, false, 'M', 'M');
        });
        $pdf::setFooterCallback(function($pdf) {
            // $pdf->SetY(-15);
            // $pdf->SetFont('helvetica', 'I', 8);
            // $pdf->Cell(373, 10, 'Hal '.$pdf->getAliasNumPage().' dari '.$pdf->getAliasNbPages(), 0, false, 'C', 0, '', 0, false, 'T', 'M');
        });
        $pdf::setFooterFont(Array(PDF_FONT_NAME_DATA, '', PDF_FONT_SIZE_DATA));
        $pdf::SetDefaultMonospacedFont(PDF_FONT_MONOSPACED);
        // $pdf::SetMargins(PDF_MARGIN_LEFT, PDF_MARGIN_BOTTOM, PDF_MARGIN_RIGHT);
        $pdf::SetHeaderMargin(PDF_MARGIN_HEADER);
        $pdf::SetFooterMargin(PDF_MARGIN_FOOTER);
        $pdf::setCellHeightRatio(1.1);
        $pdf::SetTitle('Cetak Bukti');
        $pdf::AddPage('P', 'A4');

        $style4 = array('width' => 0.75, 'cap' => 'butt', 'join' => 'miter', 'dash' => 0, 'color' => array(128, 128, 128));
        $style3 = array('width' => 0.40, 'cap' => 'butt', 'join' => 'miter', 'dash' => 0, 'color' => array(0, 0, 0));
        $style2 = array('width' => 0.75, 'cap' => 'butt', 'join' => 'miter', 'dash' => 0, 'color' => array(0, 0, 0));

        $style = array(
            'border' => 0,
            'vpadding' => 'auto',
            'hpadding' => 'auto',
            'fgcolor' => array(0,0,0),
            'bgcolor' => false,//array(255,255,255),
            'module_width' => 1, // width of a single module in points
            'module_height' => 1 // height of a single module in points
        );

       $alat =  DB::table('lab_spk')
                    ->where('id_order','=',$id_order)
                    ->where('petugas_id','=',$petugas_id)
                    ->select('alat_id')->get();
        $list='';
        foreach ($alat as $data) {
            $list=$list.$data->alat_id.',';
        }
        $alat_id=$list;
        $jum=0;
        foreach (count_chars($alat_id,1) as $i => $val) {
            if (chr($i)==",") {
                $jum=$val;
            }
        }

        $alats=explode(",", $alat_id);

        $alatku=array();
        for ($n=0; $n <$jum+1 ; $n++) { 
            array_push($alatku, preg_replace("/[^0-9]/","",$alats[$n]));
        }

        $jums = DB::table('lab_detail_order')
        ->whereIn('lab_detail_order.id',$alatku)
        ->where('lab_detail_order.id_order','=',$id_order)
        ->select(
            DB::raw('sum(lab_detail_order.jumlah) as jumlah')
        )->get();

        foreach ($jums as $jumlahs) {
           $jumlah_alat=$jumlahs->jumlah;
        }

        $penyerahan = DB::table('lab_penyerahan')
        ->select(
            'lab_penyerahan.tgl_serah',
            'lab_penyerahan.no_order',
            DB::raw('get_nama(lab_penyerahan.petugas_lab) as petugas_lab'),
            DB::raw('get_nama(lab_penyerahan.petugas_yantek) as petugas_yantek')
        )
        ->where('lab_penyerahan.id_order','=',$id_order)
        ->where('lab_penyerahan.petugas_lab','=',$petugas_id)
        ->get();

        foreach ($penyerahan as $data) {
            $tgl_serah=$data->tgl_serah;
            $no_orderz=$data->no_order;
            $petugas_lab=$data->petugas_lab;
            $petugas_yantek=$data->petugas_yantek;
        }

        $tanggal = substr($tgl_serah,8,2);
        $bulan = $this->getBulan(substr($tgl_serah,5,2));
        $tahun = substr($tgl_serah,0,4);
        $barkode=$this->who_is().'-'.Carbon::now()->format('d-m-Y').'-'.substr($petugas_lab,0,8).'-'.substr($petugas_yantek,0,8);
        $params = $pdf::serializeTCPDFtagParameters(array($barkode, 'QRCODE,H', 14, '', 30, 30, $style, 'N'));

        $detailpenerimaan = DB::table('lab_detail_order')
        ->whereIn('lab_detail_order.id',$alatku)
        ->where('lab_detail_order.id_order','=',$id_order)
        ->select(
            DB::raw('get_alat(lab_detail_order.alat_id) as alat'),
            DB::raw('get_tarif(alat_id) as tarif'),
            //DB::raw('concat("Rp ", format( get_total(alat_id), 0)) as total'),
            //DB::raw('get_total(lab_detail_order) as terbilang'),
            //DB::raw('concat("Rp ", format( get_total(no_order), 0)) as total'),
            'lab_detail_order.seri',
            'jumlah',
            'lab_detail_order.catatan'
        )
        
        ->orderBy(DB::raw('get_alat(lab_detail_order.alat_id)'),'ASC')
        ->get();

        // Ambil Total Jumlah
        $totalJumlah = DB::table('lab_detail_order')
                        ->whereIn('lab_detail_order.id',$alatku)
                        ->where('id_order', $id_order)
                        ->select(DB::raw('SUM(jumlah) as total_jumlah'))
                        ->first();

        // Ambil Total Order
        $totalOrder = DB::table('lab_detail_order')
                        ->whereIn('lab_detail_order.id',$alatku)
                        ->where('id_order', $id_order)
                        ->select(DB::raw('SUM(jumlah * get_tarif(alat_id)) as total_order'))
                        ->first();


        $isi='';
        
        $no=0;
        foreach ($detailpenerimaan as $baris) {
            $no++;
            $totalPrice = $baris->tarif*$baris->jumlah;
            $isi=$isi.'
                <tr nobr="true">
                    <td style="text-align:center"><font size="6em">'.$no.'</font></td>
                    <td><font size="8em">'.$baris->alat.'</font></td>
                    <td><font size="8em">'.$baris->seri.'</font></td>
                    <td align="center"><font size="6em">'.$baris->jumlah.'</font></td>
                    <td><font size="6em"> Rp. '.number_format($baris->tarif,0,',','.').'</font></td>
                    <td><font size="6em">Rp. '.number_format($totalPrice,0,',','.').'</font></td>
                    <td><font size="8em">'.$baris->catatan.'</font></td>
                </tr>
            ';
        }


        $table_serah='
                <table border="1" cellpadding="12" cellspacing="0">
                    <tr>
                        <td colspan="4">
                            <table border="0">
                                <tr>
                                    <td style="text-align:center" width="504px"><font size="12em"><b>BERITA ACARA PENYERAHAN ALAT</b></font></td>
                                </tr>
                                <tr><td></td></tr>
                                <tr>
                                    <td style="text-align:justify"><font size="8em">Pada hari ini, '.$this->namahari($tgl_serah).' Tanggal '.$tanggal.' bulan '.$bulan.' tahun '.$tahun.' telah diserahkan alat yang telah dikalibrasi dari pelaksana pengujian/kalibrasi pelayanan teknik sebanyak '.$jumlah_alat.' ('.$this->terbilang($jumlah_alat).' ) unit dengan nomor order '.$no_orderz.'
                                    </font></td>
                                </tr>
                                <tr><td><font size="8em">Dengan uraian alat sebagai berikut :</font></td></tr>
                            </table>
                            <table border="1" cellpadding="2" cellspacing="0">
                                    <tr align="center">
                                        <td width="25px"><font size="8em">NO</font></td>
                                        <td width="190px"><font size="8em">NAMA ALAT</font></td>
                                        <td width="50px"><font size="8em">NOMOR SERI</font></td>
                                        <td width="50px"><font size="8em">JUMLAH UNIT</font></td>
                                        <td width="50px"><font size="8em">HARGA SATUAN</font></td>
                                        <td width="50px"><font size="8em">HARGA TOTAL</font></td>
                                        <td width="100px"><font size="8em">CATATAN</font></td>
                                    </tr>
                                    '.$isi.'
                                    <tr align="center">
                                        <td colspan="3">&nbsp;</td>
                                        <td><font size="7em" style="font-weight:bold;">'.$totalJumlah->total_jumlah.'</font></td>
                                        <td colspan="3" style="text-align:left;"><font size="7em" style="font-weight:bold;">Total Harga : Rp. '.number_format($totalOrder->total_order,0,',','.').'</font></td>
                                    </tr>
                            </table>
                            <table>
                                    <tr><td colspan="4"></td></tr>
                                    <tr align="left"><td colspan="4"><font size="8em">Demikian Berita acara ini dibuat untuk digunakan seperlunya</font></td></tr>
                                    <tr>
                                        <td><tcpdf method="write2DBarcode" params="'.$params.'" /></td>
                                        <td colspan="3"></td>
                                    </tr>
                                    <tr><td colspan="4"></td></tr>
                                    <tr><td colspan="4"></td></tr>
                                    <tr><td colspan="4"></td></tr>
                                    <tr><td colspan="4"></td></tr>
                                    <tr><td colspan="4"></td></tr>
                                    <tr><td colspan="4"></td></tr>
                                    <tr><td colspan="4"></td></tr>
                                    <tr align="center"><td colspan="4"><font size="8em"><i>Tidak dibenarkan memperbanyak, mengutip atau memiliki sebagian/keseluruhan isi dokumen ini tanpa ijin dari LPFK Banjarbaru</i></font></td></tr>
                            </table>
                        </td>
      
                    </tr>
                </table>
        ';
        // $barkode=Carbon::now()->format('d-m-Y').$ka.$nip_ka;
        $pdf::image('img/kop.png', 6, 8, 195,'', 'png', '', 'T', false, 300, '', false, false, 0, false, false, false);
        $pdf::SetFont('courier', '', 9);
        $pdf::Text(176, 5, 'F-5.8a Rev.2'); 
        $pdf::SetFont('helvetica', '', 11);
        $pdf::SetY(47);       
        $pdf::Line(10, 43, 200, 43, $style3);
        $pdf::Line(10, 42, 200, 42, $style2);    
        $pdf::writeHTML($table_serah, true, false, true, false, '');
        // $pdf::write1DBarcode($barkode, 'C128', 122, '', '', 18, 0.4, $style, 'N');
        $pdf::lastPage();
        $pdf::Output('Penyerahan-'.$no_orderz.'-'.Carbon::now()->toDateTimeString().'pdf');
    }

    public function cetakBukti($no_order,$id)
    {
        $pdf = new TCPDF();
        $pdf::setHeaderCallback(function($pdf) {
            // $pdf->SetFont('helvetica', 'B', 20);
            // $pdf->Cell(0, 15, 'Something new right here!!!', 0, false, 'C', 0, '', 0, false, 'M', 'M');
        });
        $pdf::setFooterCallback(function($pdf) {
            // $pdf->SetY(-15);
            // $pdf->SetFont('helvetica', 'I', 8);
            // $pdf->Cell(373, 10, 'Hal '.$pdf->getAliasNumPage().' dari '.$pdf->getAliasNbPages(), 0, false, 'C', 0, '', 0, false, 'T', 'M');
        });
        $pdf::setFooterFont(Array(PDF_FONT_NAME_DATA, '', PDF_FONT_SIZE_DATA));
        $pdf::SetDefaultMonospacedFont(PDF_FONT_MONOSPACED);
        // $pdf::SetMargins(PDF_MARGIN_LEFT, PDF_MARGIN_BOTTOM, PDF_MARGIN_RIGHT);
        $pdf::SetAutoPageBreak(TRUE, 6);
        $pdf::SetHeaderMargin(PDF_MARGIN_HEADER);
        $pdf::SetFooterMargin(PDF_MARGIN_FOOTER);
        $pdf::setCellHeightRatio(1);
        $pdf::SetTitle('Cetak Penyerahan Pekerjaan');
        $pdf::AddPage('P', 'A4');

        $style4 = array('width' => 0.75, 'cap' => 'butt', 'join' => 'miter', 'dash' => 0, 'color' => array(128, 128, 128));
        $style3 = array('width' => 0.40, 'cap' => 'butt', 'join' => 'miter', 'dash' => 0, 'color' => array(0, 0, 0));
        $style2 = array('width' => 0.75, 'cap' => 'butt', 'join' => 'miter', 'dash' => 0, 'color' => array(0, 0, 0));

        $style = array(
            'border' => 0,
            'vpadding' => 'auto',
            'hpadding' => 'auto',
            'fgcolor' => array(0,0,0),
            'bgcolor' => false,//array(255,255,255),
            'module_width' => 1, // width of a single module in points
            'module_height' => 1 // height of a single module in points
        );


        $bukti = DB::table('lab_bukti')
        ->join('lab_customer', 'lab_bukti.no_order', '=', 'lab_customer.no_order')
        ->where('lab_bukti.id','=',$id)
        ->select(
            'lab_customer.no_order as no_order',
            'lab_customer.pemilik as pemilik',
            'lab_bukti.alat_id as alat_id',
            'lab_bukti.tgl_serah as tgl_serah',
            'lab_bukti.penerima as penerima',
            DB::raw('get_nama(lab_bukti.penyerah) as penyerah'),
            'lab_bukti.p1 as p1',
            'lab_bukti.p2 as p2',
            'lab_bukti.p3 as p3',
            'lab_bukti.p4 as p4'
        )->get();

        foreach ($bukti as $data) {
            $no_orderz=$data->no_order;
            $alat_id=$data->alat_id;
            $pemilik=$data->pemilik;
            $tgl_serah=$this->tgl_indo($data->tgl_serah);
            $penerima=$data->penerima;
            $penyerah=$data->penyerah;
            $p1=$data->p1;
            $p2=$data->p2;
            $p3=$data->p3;
            $p4=$data->p4;
        }

        $jum=0;
        foreach (count_chars($alat_id,1) as $i => $val) {
            if (chr($i)==",") {
                $jum=$val;
            }
        }

        $alats=explode(",", $alat_id);
        $alatku=array();
        for ($n=0; $n <$jum+1 ; $n++) { 
            array_push($alatku, preg_replace("/[^0-9]/","",$alats[$n]));
        }


        if ($p1==1) {
            $gb1='<img src="img/boxc.png" height="7" />';
        }else{
            $gb1='<img src="img/box.png" height="7" />';
        }

        if ($p2==1) {
            $gb2='<img src="img/boxc.png" height="7" />';
        }else{
            $gb2='<img src="img/box.png" height="7" />';
        }

        if ($p3==1) {
            $gb3='<img src="img/boxc.png" height="7" />';
        }else{
            $gb3='<img src="img/box.png" height="7" />';
        }

        if ($p4==1) {
            $gb4='<img src="img/boxc.png" height="7" />';
        }else{
            $gb4='<img src="img/box.png" height="7" />';
        }

        $detailpenerimaan = DetailPenerimaan::select([
            DB::raw('get_alat(alat_id) as alat'),
            'seri',
            'jumlah',
            'catatan'
        ])->where('id_order', '=', $no_order)
          ->whereIn('id',$alatku)
          ->orderBy(DB::raw('get_alat(alat_id)'),'ASC')
          ->get();
        $jumlah=$detailpenerimaan->count();

        $isi='';
        $no=0;
        foreach ($detailpenerimaan as $rows) {
            $no++;
            $isi=$isi.'
                <tr>
                    <td style="text-align:center"><font size="8em">'.$no.'</font></td>
                    <td><font size="8em">'.$rows->alat.'</font></td>
                    <td><font size="8em">'.$rows->seri.'</font></td>
                    <td style="text-align:center"><font size="8em">'.$rows->jumlah.'</font></td>
                    <td><font size="8em">'.$rows->catatan.'</font></td>
                </tr>
            ';
        }

        $barkode=$this->who_is().'-'.Carbon::now()->format('d-m-Y').'-'.$penyerah;
        $params = $pdf::serializeTCPDFtagParameters(array($barkode, 'PDF417', 47, '', 250, 20, $style, 'N'));
        // $params = $pdf::serializeTCPDFtagParameters(array($barkode, 'QRCODE,H', 47, '', 30, 30, $style, 'N'));
        // $params = $pdf::serializeTCPDFtagParameters(array($barkode, 'C128', '', '', '', 18, 0.4, $style, 'N'));

        $table_bukti='
                <table border="1" cellpadding="12" cellspacing="0">
                    <tr>
                        <td colspan="4">
                            <table border="0">
                                <tr>
                                    <td style="text-align:center" width="504px"><font size="12em"><b>BUKTI PENYERAHAN PEKERJAAN</b></font></td>
                                </tr>
                                <tr><td></td></tr>
                                <tr>
                                    <td width="150px"><font size="8em">Nomor Order</font></td>
                                    <td width="10px"><font size="8em">:</font></td>
                                    <td width="343.8px"><font size="8em">'.$no_orderz.'</font></td>
                                </tr>
                                <tr>
                                    <td><font size="8em">Instansi Pemilik Barang</font></td>
                                    <td><font size="8em">:</font></td>
                                    <td><font size="8em">'.$pemilik.'</font></td>
                                </tr>
                                <tr>
                                    <td><font size="8em">Tanggal Penyerahan</font></td>
                                    <td><font size="8em">:</font></td>
                                    <td><font size="8em">'.$tgl_serah.'</font></td>
                                </tr>
                                <tr><td></td></tr>
                            </table>
                            <table border="1" cellpadding="2" cellspacing="0">
                                    <tr align="center">
                                        <td width="25px" rowspan="2" style="line-height:20px"><font size="8em">NO</font></td>
                                        <td width="200px" rowspan="2" style="line-height:20px"><font size="8em">NAMA ALAT</font></td>
                                        <td width="109px" rowspan="2" style="line-height:20px"><font size="8em">NO SERI</font></td>
                                        <td width="70px"><font size="8em">JUMLAH</font></td>
                                        <td width="100px" rowspan="2" style="line-height:20px"><font size="8em">CATATAN</font></td>
                                    </tr>
                                    <tr align="center">
                                        <td><font size="8em">UNIT</font></td>
                                    </tr>
                                    '.$isi.'
                            </table>
                            <table border="0">
                                <tr align="left"><td colspan="2" width="504px"></td></tr>
                                <tr align="left"><td colspan="2" width="504px"><font size="8em">Catatan :</font></td></tr>
                                <tr align="left">
                                    <td width="504px">'.$gb1.'&nbsp;<font size="8em">Diserahkan Alat/Barang sesuai dengan daftar di atas</font></td>
                                </tr>
                                <tr align="left">
                                    <td width="504px">'.$gb2.'&nbsp;<font size="8em">Diserahkan Sertifikat/Lembar Hasil Pengujian/Kalibrasi sesuai dengan daftar di atas</font></td>
                                </tr>
                                <tr align="left">
                                    <td width="504px">'.$gb3.'&nbsp;<font size="8em">Batal diuji/dikalibrasi (dalam keterangan)</font></td>
                                </tr>
                                <tr align="left">
                                    <td width="504px">'.$gb4.'&nbsp;<font size="8em">Alat/Barang atau Dokumen sudah diperiksa oleh pelanggan</font></td>
                                </tr>
                                <tr><td colspan="4" width="504px"></td></tr>
                                    <tr>
                                        <td colspan="2" rowspan="6"><tcpdf method="write2DBarcode" params="'.$params.'" /></td>
                                        <td colspan="2" style="text-align:center"><font size="8em">Diterima oleh,</font></td>
                                    </tr>
                                    <tr><td colspan="2"></td></tr>
                                    <tr><td colspan="2"></td></tr>
                                    <tr><td colspan="2"></td></tr>
                                    <tr><td colspan="2"></td></tr>
                                    <tr>
                                        <td colspan="2" style="text-align:center"><font size="8em">'.$penerima.'</font></td>
                                    </tr>
                                    <tr><td colspan="4"></td></tr>
                                    <tr><td colspan="4"></td></tr>
                                    <tr><td colspan="4"></td></tr>
                                    <tr><td colspan="4"></td></tr>
                                    <tr><td colspan="4"></td></tr>
                                    <tr><td colspan="4"></td></tr>
                                    <tr><td colspan="4"></td></tr>
                                    <tr align="center"><td colspan="4"><font size="8em"><i>Tidak dibenarkan memperbanyak, mengutip atau memiliki sebagian/keseluruhan isi dokumen ini tanpa ijin dari LPFK Banjarbaru</i></font></td></tr>
                            </table>
                        </td>
      
                    </tr>
                </table>
        ';

        $pdf::image('img/kop.png', 8, 10, 192,'', 'png', '', 'T', false, 300, '', false, false, 0, false, false, false);
        $pdf::SetFont('courier', '', 9);
        $pdf::Text(176, 5, 'F-5.8b Rev.2'); 
        $pdf::SetFont('helvetica', '', 9);
        $pdf::SetY(48);       
        $pdf::Line(10, 45, 200, 45, $style3);
        $pdf::Line(10, 44, 200, 44, $style2);    
        $pdf::writeHTML($table_bukti, true, false, true, false, '');
        // $pdf::write1DBarcode($barkode, 'C128', 122, '', '', 18, 0.4, $style, 'N');
        $pdf::lastPage();
        $pdf::Output('Penyerahan-'.$no_orderz.'-'.Carbon::now()->toDateTimeString().'pdf');
    }
}
