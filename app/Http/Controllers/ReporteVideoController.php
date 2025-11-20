<?php

namespace App\Http\Controllers;

use App\Models\ReporteVideo;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Validator;

class ReporteVideoController extends Controller
{
    public function index($reporteId)
    {
        $videos = ReporteVideo::where('reporte_id', $reporteId)
            ->orderBy('orden')
            ->get();
        
        return response()->json($videos);
    }

    public function store(Request $request, $reporteId)
    {
        $validator = Validator::make($request->all(), [
            'url' => 'required|url',
            'orden' => 'nullable|integer|min:0'
        ]);

        if ($validator->fails()) {
            return response()->json(['errors' => $validator->errors()], 422);
        }

        $video = ReporteVideo::create([
            'reporte_id' => $reporteId,
            'url' => $request->url,
            'orden' => $request->orden ?? 0
        ]);
        
        return response()->json($video, 201);
    }

    public function update(Request $request, $reporteId, $id)
    {
        $video = ReporteVideo::where('reporte_id', $reporteId)
            ->findOrFail($id);

        $validator = Validator::make($request->all(), [
            'url' => 'sometimes|url',
            'orden' => 'nullable|integer|min:0'
        ]);

        if ($validator->fails()) {
            return response()->json(['errors' => $validator->errors()], 422);
        }

        $video->update($request->all());
        
        return response()->json($video);
    }

    public function destroy($reporteId, $id)
    {
        $video = ReporteVideo::where('reporte_id', $reporteId)
            ->findOrFail($id);
        $video->delete();
        
        return response()->json(['message' => 'Video eliminado correctamente'], 200);
    }

    public function reordenar(Request $request, $reporteId)
    {
        $validator = Validator::make($request->all(), [
            'videos' => 'required|array',
            'videos.*.id' => 'required|exists:reporte_videos,id',
            'videos.*.orden' => 'required|integer|min:0'
        ]);

        if ($validator->fails()) {
            return response()->json(['errors' => $validator->errors()], 422);
        }

        foreach ($request->videos as $item) {
            ReporteVideo::where('id', $item['id'])
                ->where('reporte_id', $reporteId)
                ->update(['orden' => $item['orden']]);
        }
        
        return response()->json(['message' => 'Videos reordenados correctamente'], 200);
    }
}