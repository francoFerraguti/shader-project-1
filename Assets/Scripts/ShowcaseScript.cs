using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class ShowcaseScript : MonoBehaviour
{
    float timer = 0;
    float timeToActivate = 1.8f;
    float timeToDesactivate = 1.85f;
    float activationRotatingSpeed = 1900.0f;

    float rotatingSpeed = 20.0f;

    void Update()
    {
        transform.Rotate(-Vector3.up * Time.deltaTime * rotatingSpeed);

        timer += Time.deltaTime;
        if (timer >= timeToActivate)
        {
            transform.Rotate(-Vector3.right * Time.deltaTime * activationRotatingSpeed);
        }
        if (timer >= timeToDesactivate)
        {
            timer = 0;
        }
    }
}
