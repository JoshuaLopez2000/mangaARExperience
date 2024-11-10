using UnityEngine;
using UnityEngine.UI;

public class ModificarModelo : MonoBehaviour
{
    public GameObject modelo3D;
    public Button boton;

    public void CambiarColor()
    {
        Renderer renderer = modelo3D.GetComponent<Renderer>();
        if (renderer != null)
        {
            Color nuevoColor = new Color(Random.value, Random.value, Random.value);

            renderer.material.color = nuevoColor;

            ColorBlock colorBlock = boton.colors;
            colorBlock.normalColor = nuevoColor;
            colorBlock.highlightedColor = nuevoColor;
            colorBlock.pressedColor = nuevoColor * 0.9f;
            colorBlock.selectedColor = nuevoColor;
            boton.colors = colorBlock;
        }
    }
}
