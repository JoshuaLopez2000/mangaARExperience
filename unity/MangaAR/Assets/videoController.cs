using UnityEngine;
using Vuforia;
using UnityEngine.Video;

public class VideoPlayback : MonoBehaviour
{
    private ObserverBehaviour mObserverBehaviour;
    public VideoPlayer videoPlayer;
    public Renderer quadRenderer; // Quad que contiene el material inicial y el video
    public string videoFileName = "your_video.mp4"; // Nombre del archivo en StreamingAssets
    private bool isPrepared = false; // Bandera para controlar el estado del video
    private bool isTracked = false; // Bandera para rastrear el estado del ImageTarget

    void Start()
    {
        // Vincula el evento de cambio de estado del ImageTarget
        mObserverBehaviour = GetComponent<ObserverBehaviour>();
        if (mObserverBehaviour)
        {
            mObserverBehaviour.OnTargetStatusChanged += OnTargetStatusChanged;
        }

        // Configura la ruta del video desde StreamingAssets
        string videoPath = System.IO.Path.Combine(Application.streamingAssetsPath, videoFileName);
        videoPlayer.url = videoPath;

        // Prepara el video al inicio
        PrepareVideo();
    }

    private void OnDestroy()
    {
        // Desvincula el evento al destruir el objeto
        if (mObserverBehaviour)
        {
            mObserverBehaviour.OnTargetStatusChanged -= OnTargetStatusChanged;
        }
    }

    private void PrepareVideo()
    {
        if (!isPrepared)
        {
            videoPlayer.Prepare();
            videoPlayer.prepareCompleted += OnVideoPrepared;
        }
    }

    private void OnTargetStatusChanged(ObserverBehaviour behaviour, TargetStatus targetStatus)
    {
        isTracked = (targetStatus.Status == Status.TRACKED);

        if (isTracked)
        {
            if (isPrepared)
            {
                videoPlayer.Play();
            }
            else
            {
                PrepareVideo();
            }
        }
        else
        {
            if (videoPlayer.isPlaying)
            {
                videoPlayer.Stop();
                isPrepared = false;
            }
        }
    }

    private void OnVideoPrepared(VideoPlayer vp)
    {
        Debug.Log("Video preparado y listo para reproducirse");
        isPrepared = true;

        if (isTracked)
        {
            videoPlayer.Play();
        }
    }
}